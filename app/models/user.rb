# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                       :bigint           not null, primary key
#  confirmation_sent_at     :datetime
#  confirmation_token       :string
#  confirmed                :boolean          default(FALSE)
#  confirmed_at             :datetime
#  deactivated              :boolean          default(FALSE)
#  deleted_at               :datetime
#  display_name             :string
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  first_name               :string           not null
#  google_calendar_required :boolean          default(FALSE), not null
#  google_calendar_status   :boolean          default(FALSE), not null
#  hide_history             :boolean          default(FALSE)
#  invitation_accepted_at   :datetime
#  invitation_created_at    :datetime
#  invitation_limit         :integer
#  invitation_sent_at       :datetime
#  invitation_token         :string
#  invitations_count        :integer          default(0)
#  invited_by_type          :string
#  last_name                :string           not null
#  nick                     :string
#  remember_created_at      :datetime
#  reset_password_sent_at   :datetime
#  reset_password_token     :string
#  time_zone                :string           default("Europe/Kiev")
#  unconfirmed_email        :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  company_id               :integer
#  discord_user_id          :bigint
#  invited_by_id            :bigint
#  telegram_chat_id         :integer
#
# Indexes
#
#  index_users_on_deleted_at                         (deleted_at)
#  index_users_on_email                              (email) UNIQUE
#  index_users_on_invitation_token                   (invitation_token) UNIQUE
#  index_users_on_invited_by_id                      (invited_by_id)
#  index_users_on_invited_by_type_and_invited_by_id  (invited_by_type,invited_by_id)
#  index_users_on_reset_password_token               (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => user_companies.id)
#
class User < ApplicationRecord

  self.table_name = :users

  acts_as_paranoid

  devise :invitable, :recoverable, :database_authenticatable, :timeoutable, :rememberable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  include Filterable
  include UserModule::Associations
  include UserModule::Scopes
  include UserModule::Helpers
  include UserModule::Validations

  before_save :set_default_names
  after_update :change_user

  SCOPES_BY_DISCIPLINE_OR_DEFAULT = %w[staff_members participants main_participants media_representatives commentators
                                       analytics managers only_deleted].freeze

  def set_default_names
    self.first_name ||= ''
    self.last_name ||= ''

    self.display_name = generate_display_name
  end

  def change_user
    if saved_changes[:google_calendar_status]
      _old, new = saved_changes[:google_calendar_status]

      user_api_token&.destroy if new == false
    end
  end

  def deleted_avatar_url
    return '' unless ArchivedImageResource.where(item_type: 'User', item_id: id).last

    UrlGenerator.attachment_url(ArchivedImageResource.where(item_type: 'User', item_id: id).last.resource)
  end

  def related_tournaments
    Tournament
      .distinct
      .where("EXISTS (SELECT 1 FROM tournament_main_participants WHERE
      tournaments.id = tournament_main_participants.tournament_id AND tournament_main_participants.user_id = :user_id)
              OR EXISTS (SELECT 1 FROM tournament_media_representatives
            WHERE tournaments.id = tournament_media_representatives.tournament_id
              AND tournament_media_representatives.user_id = :user_id)
              OR EXISTS (SELECT 1 FROM match_staff_members
            WHERE tournaments.id = match_staff_members.tournament_id AND match_staff_members.user_id = :user_id)
              OR EXISTS (SELECT 1 FROM match_commentators
            WHERE tournaments.id = match_commentators.tournament_id AND match_commentators.user_id = :user_id)
              OR EXISTS (SELECT 1 FROM match_analytics
            WHERE tournaments.id = match_analytics.tournament_id AND match_analytics.user_id = :user_id)",
             user_id: id)
      .select(:id, :title)
  end

  def cast_context_matches
    Match.joins(:match_casts)
         .where("match_casts.id IN (SELECT match_cast_id FROM match_commentators
              WHERE user_id = :user_id) OR match_casts.id IN (SELECT match_cast_id FROM match_analytics
              WHERE user_id = :user_id) OR match_casts.id IN (SELECT match_cast_id FROM match_staff_members
              WHERE user_id = :user_id)", user_id: id)
         .distinct
  end

  def update_display_name_column
    update_column(:display_name, generate_display_name) # rubocop:disable Rails/SkipsModelValidations
  end

  private

  def generate_display_name
    name = [first_name, last_name].reject(&:blank?).join(' ')

    if user_has_required_disciplines?
      nick.presence || name
    else
      name.presence || nick
    end
  end

  def user_has_required_disciplines?
    user_disciplines.where(title: %w[Commentator Analytic]).exists?
  end

end

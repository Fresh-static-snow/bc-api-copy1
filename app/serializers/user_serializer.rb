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
class UserSerializer < Blueprinter::Base

  identifier :id

  view :user_name do
    fields :display_name, :nick
  end

  view :common do
    fields :email, :first_name, :last_name, :display_name, :nick
    association :company, blueprint: UserCompanySerializer, view: :list
    association :avatar, blueprint: ImageSerializer
  end

  view :dashboard_list do
    fields :display_name
    association :avatar, blueprint: ImageSerializer
  end

  view :show do
    include_view :common
    include_view :events_fields

    field :google_calendar do |user|
      {
        status: user.google_calendar_status,
        required: user.google_calendar_required,
        connected: user.user_api_token.present?,
        link: GoogleApi::CalendarV3::GetAuthLink.call
      }
    end

    association :roles, blueprint: RoleSerializer, view: :common
    association :user_disciplines, blueprint: UserDisciplineSerializer, view: :list
  end

  view :edit do
    include_view :common
    association :roles, blueprint: RoleSerializer, view: :common
    association :user_disciplines, blueprint: UserDisciplineSerializer, view: :list
    association :user_notifications, blueprint: UserNotificationSerializer
  end

  view :with_role do
    include_view :common
    association :roles, blueprint: RoleSerializer, view: :common
  end

  view :calendar do
    fields :first_name, :last_name, :display_name, :nick
    association :avatar, blueprint: ImageSerializer
  end

  view :list do
    include_view :user_name
    association :avatar, blueprint: ImageSerializer
  end

  view :main_participants do
    include_view :list
  end

  view :media_representatives do
    include_view :list
  end

  view :commentators do
    include_view :list
    include_view :talent_availability
  end

  view :analytics do
    include_view :list
    include_view :talent_availability
  end

  view :staff_members do
    include_view :list
    include_view :talent_availability
  end

  view :managers do
    include_view :list
  end

  view :participants do
    include_view :list
    association :user_disciplines, blueprint: UserDisciplineSerializer, view: :list
  end

  view :notify do
    field :id
    field :title do |user| # rubocop:disable Style/SymbolProc
      user.display_name
    end
    field :is_deleted do |user|
      user.deleted_at.present?
    end
  end

  view :only_deleted do
    include_view :with_role
    include_view :events_fields

    field :avatar do |user|
      {
        url: user.deleted_avatar_url
      }
    end
  end

  view :events_fields do
    field :events_count do |user|
      user.related_tournaments.size
    end

    field :related_events do |user| # rubocop:disable Style/SymbolProc
      user.related_tournaments
    end
  end

  view :talent_availability do
    field :is_unavailable do |user, options|
      if options['start_at']
        match_id   = options['match_id']
        start_time = Time.zone.parse(options['start_at'])
        end_time   = options['end_at'] ? Time.zone.parse(options['end_at']) : start_time + 1.hour

        user.cast_context_matches
            .where("(:start_at >= start_at AND :start_at < COALESCE(end_at,
                    start_at + INTERVAL '#{Setting.default_match_duration}')) OR
                  (:end_at > start_at AND :end_at < COALESCE(end_at,
                    start_at + INTERVAL '#{Setting.default_match_duration}')) OR
                  (:start_at <= start_at AND :end_at >= COALESCE(end_at,
                    start_at + INTERVAL '#{Setting.default_match_duration}'))",
                   start_at: start_time, end_at: end_time)
            .where.not(id: match_id).any?
      else
        false
      end
    end
  end

end

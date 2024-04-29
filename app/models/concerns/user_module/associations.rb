# frozen_string_literal: true

module UserModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_one_attached :avatar, dependent: :purge_later

      has_one :sign_up_request, dependent: :destroy
      has_one :user_api_token, dependent: :destroy

      has_many :user_discipline_memberships, dependent: :destroy
      has_many :user_disciplines, through: :user_discipline_memberships
      alias_method :as_disciplines, :user_disciplines

      has_many :user_roles, dependent: :destroy
      has_many :roles, through: :user_roles
      alias_method :as_roles, :roles

      has_many :tournaments, foreign_key: 'owner_id', dependent: :nullify, inverse_of: :owner

      has_many :user_notifications, dependent: :destroy
      has_many :author_notifications, foreign_key: 'author_id', class_name: 'UserNotification', dependent: :destroy,
                                      inverse_of: :author

      has_many :entity_comments, dependent: :destroy

      belongs_to :company, class_name: 'UserCompany', optional: true, inverse_of: :users

      has_many :match_host_analytics, class_name: 'MatchContext::HostAnalytic', dependent: :destroy, source: :match_cast
      has_many :host_analytics, class_name: 'MatchCast', through: :match_host_analytics, source: :match_cast

      has_many :match_backup_commentators, class_name: 'MatchContext::BackupCommentator', dependent: :destroy, source: :match_cast
      has_many :backup_commentators, class_name: 'MatchCast', through: :match_backup_commentators, source: :match_cast

      has_many :tournament_main_participants, class_name: 'TournamentContext::MainParticipants', dependent: :destroy
      has_many :main_participant_tournaments, through: :tournament_main_participants, source: :tournament

      has_many :tournament_media_representatives, class_name: 'TournamentContext::MediaRepresentatives',
                                                  dependent: :destroy
      has_many :media_representative_tournaments, through: :tournament_media_representatives, source: :tournament
      alias_method :as_media_representative_tournaments, :media_representative_tournaments

      has_many :corporate_main_participants, class_name: 'CorporateMainParticipants', dependent: :destroy
      has_many :main_participant_corporates, through: :corporate_main_participants
      alias_method :as_main_participant_corporates, :main_participant_corporates

      has_many :corporate_participants, class_name: 'CorporateParticipants', dependent: :destroy
      has_many :participant_corporates, through: :corporate_participants
      alias_method :as_participant_corporates, :participant_corporates

      has_many :match_analytics, class_name: 'MatchContext::Analytics', dependent: :destroy
      has_many :match_analytic_casts, class_name: 'MatchCast', through: :match_analytics, source: :match_cast

      has_many :match_commentators, class_name: 'MatchContext::Commentators', dependent: :destroy
      has_many :match_commentator_casts, class_name: 'MatchCast', through: :match_commentators, source: :match_cast

      has_many :match_staff_members, class_name: 'MatchContext::StaffMembers', dependent: :destroy
      has_many :match_staff_member_casts, class_name: 'MatchCast', through: :match_staff_members, source: :match_cast
    end

  end
end

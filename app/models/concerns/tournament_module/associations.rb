# frozen_string_literal: true

module TournamentModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :region, optional: true
      belongs_to :type, class_name: 'TournamentContext::Type', optional: true
      has_many :matches, dependent: :destroy

      has_many :comments, class_name: 'EntityComment', as: :entity, dependent: :destroy

      belongs_to :owner, class_name: 'User', optional: true

      belongs_to :game_discipline, optional: true
      alias_method :discipline, :game_discipline

      has_many :descriptions, class_name: 'TournamentContext::Description', dependent: :destroy
      accepts_nested_attributes_for :descriptions, allow_destroy: true, reject_if: :reject_descriptions

      has_many :media, class_name: 'TournamentContext::Media', dependent: :destroy
      accepts_nested_attributes_for :media, allow_destroy: true, reject_if: :reject_media

      has_many :tournament_main_participants, class_name: 'TournamentContext::MainParticipants', dependent: :destroy
      has_many :main_participants, -> { User.with_history.distinct }, through: :tournament_main_participants, source: :user
      has_many :main_participants_without_history, through: :tournament_main_participants, source: :user

      has_many :tournament_media_representatives, class_name: 'TournamentContext::MediaRepresentatives',
                                                  dependent: :destroy
      has_many :media_representatives, -> { User.with_history.distinct }, through: :tournament_media_representatives,
                                                                          source: :user
      has_many :media_representatives_without_history, through: :tournament_media_representatives, source: :user

      has_many :tournament_sponsors, class_name: 'TournamentContext::Sponsors', dependent: :destroy
      has_many :sponsors, through: :tournament_sponsors
      accepts_nested_attributes_for :sponsors

      has_many :match_context_staff_members, class_name: 'MatchContext::StaffMembers', dependent: :destroy
      has_many :staff, -> { User.with_history.distinct }, through: :match_context_staff_members, source: :user
      has_many :staff_without_history, through: :match_context_staff_members, source: :user

      has_many :match_context_analytics, class_name: 'MatchContext::Analytics', dependent: :destroy
      has_many :analytics, -> { User.with_history.distinct }, through: :match_context_analytics, source: :user
      has_many :analytics_without_history, through: :match_context_analytics, source: :user

      has_many :match_context_commentators, class_name: 'MatchContext::Commentators', dependent: :destroy
      has_many :commentators, -> { User.with_history.distinct }, through: :match_context_commentators, source: :user
      has_many :commentators_without_history, through: :match_context_commentators, source: :user

      has_many :match_backup_commentator, class_name: 'MatchContext::BackupCommentator', dependent: :destroy
      has_many :backup_commentators, -> { User.with_history.distinct }, through: :match_backup_commentator, source: :user
      accepts_nested_attributes_for :match_backup_commentator, allow_destroy: true

      has_many :match_host_analytic, class_name: 'MatchContext::HostAnalytic', dependent: :destroy
      has_many :host_analytics, -> { User.with_history.distinct }, through: :match_host_analytic, source: :user
      accepts_nested_attributes_for :match_host_analytic, allow_destroy: true
    end

  end
end

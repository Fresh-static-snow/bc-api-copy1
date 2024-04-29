# frozen_string_literal: true

module MatchCastModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :match

      language_options = {
        class_name: 'CastContext::Language',
        foreign_key: :cast_language_id,
        inverse_of: :match_casts,
        optional: true
      }
      belongs_to :language, language_options

      analytic_studio_options = {
        class_name: 'CastContext::AnalyticStudio',
        foreign_key: :cast_analytic_studio_id,
        inverse_of: :match_casts,
        optional: true
      }
      belongs_to :analytic_studio, analytic_studio_options

      studio_options = {
        class_name: 'CastContext::Studio',
        foreign_key: :cast_studio_id,
        inverse_of: :match_casts,
        optional: true
      }
      belongs_to :studio, studio_options

      has_one :match_backup_commentator, class_name: 'MatchContext::BackupCommentator', dependent: :destroy
      has_one :backup_commentator, through: :match_backup_commentator, source: :user
      has_one :backup_commentator_deleted, -> { User.only_deleted }, through: :match_backup_commentator, source: :user
      accepts_nested_attributes_for :match_backup_commentator, allow_destroy: true

      has_one :match_host_analytic, class_name: 'MatchContext::HostAnalytic', dependent: :destroy
      has_one :host_analytic, through: :match_host_analytic, source: :user
      has_one :host_analytic_deleted, -> { User.only_deleted }, through: :match_host_analytic, source: :user
      accepts_nested_attributes_for :match_host_analytic, allow_destroy: true

      has_many :match_casts_channels, dependent: :destroy, source: :channel
      has_many :cast_channels, through: :match_casts_channels, dependent: :destroy, source: :channel
      has_many :channels, through: :match_casts_channels, dependent: :destroy, source: :channel
      accepts_nested_attributes_for :match_casts_channels, allow_destroy: true
      accepts_nested_attributes_for :cast_channels, allow_destroy: true

      has_many :match_analytics, class_name: 'MatchContext::Analytics', dependent: :destroy
      has_many :analytics, -> { User.with_deleted.with_history.order('match_analytics.id') },
               through: :match_analytics, source: :user
      has_many :analytics_without_history, through: :match_analytics, source: :user
      accepts_nested_attributes_for :match_analytics, allow_destroy: true
      accepts_nested_attributes_for :analytics, allow_destroy: true

      has_many :match_commentators, class_name: 'MatchContext::Commentators', dependent: :destroy
      has_many :commentators, -> { User.with_deleted.with_history.order('match_commentators.id') },
               through: :match_commentators, source: :user
      has_many :commentators_without_history, through: :match_commentators, source: :user
      accepts_nested_attributes_for :match_commentators, allow_destroy: true
      accepts_nested_attributes_for :commentators, allow_destroy: true

      has_many :match_staff_members, class_name: 'MatchContext::StaffMembers', dependent: :destroy
      has_many :staff_members, -> { User.with_deleted.with_history.order('match_staff_members.id') },
               through: :match_staff_members, source: :user
      has_many :staff_members_without_history, through: :match_staff_members, source: :user
      accepts_nested_attributes_for :match_staff_members, allow_destroy: true
      accepts_nested_attributes_for :staff_members, allow_destroy: true
    end

  end
end

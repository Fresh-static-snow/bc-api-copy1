# frozen_string_literal: true

module MatchModule
  module Scopes # rubocop:disable Metrics/ModuleLength

    extend ActiveSupport::Concern

    included do
      scope :filter_by_period_from, -> (period_from) {
        where('matches.start_at >= ?', period_from.change(offset: 'EEST'))
      }

      scope :filter_by_period_to, -> (period_to) {
        where('matches.start_at <= ?', period_to.change(offset: 'EEST'))
      }

      scope :filter_by_game_discipline, -> (game_discipline_id) {
        where('tournaments.game_discipline_id': game_discipline_id)
      }
      scope :filter_by_studio, -> (studio_id) {
        where('match_casts.cast_studio_id': studio_id)
      }
      scope :filter_by_analytic_studio, -> (analytic_studio_id) {
        where('match_casts.cast_analytic_studio_id': analytic_studio_id)
      }
      scope :filter_by_setup, -> (setup_id) {
        where('match_casts.cast_setup_id': setup_id)
      }
      scope :filter_by_stream, -> (stream_id) {
        where('match_casts.cast_stream_id': stream_id)
      }
      scope :filter_by_channel, -> (channel_id) {
        where('match_casts_channels.channel_id': channel_id)
      }
      scope :filter_by_managers, -> (managers_id) {
        where('tournaments.owner_id': managers_id)
      }
      scope :filter_by_main_participants, -> (main_participants_id) {
        where('tournament_main_participants.user_id': main_participants_id)
      }
      scope :filter_by_media_representatives, -> (media_representative_id) {
        where('tournament_media_representatives.user_id': media_representative_id)
      }
      scope :filter_by_staff_members, -> (staff_members_id) {
        where('match_staff_members.user_id': staff_members_id)
      }
      scope :filter_by_analytics, -> (analytics_id) {
        where('match_analytics.user_id': analytics_id)
      }
      scope :filter_by_commentators, -> (commentator_id) {
        where('match_commentators.user_id': commentator_id)
      }
      scope :filter_by_backup_commentators, -> (commentator_id) {
        where('match_backup_commentators.user_id': commentator_id)
      }
      scope :filter_by_host_analytic, -> (analytics_id) {
        where('match_host_analytics.user_id': analytics_id)
      }
      scope :filter_by_match_ids, -> (ids) {
        where('matches.id': ids)
      }

      scope :filter_by_params, -> (params) {
        conditions = []
        conditions_params = []
        if params[:game_discipline].present?
          conditions << "tournaments.game_discipline_id IN (?)"
          conditions_params << params[:game_discipline]
        end

        if params[:studio].present?
          conditions << "match_casts.cast_studio_id IN (?)"
          conditions_params << params[:studio]
        end

        if params[:analytic_studio].present?
          conditions << "match_casts.cast_analytic_studio_id IN (?)"
          conditions_params << params[:analytic_studio]
        end

        if params[:setup].present?
          conditions << "match_casts.cast_setup_id IN (?)"
          conditions_params << params[:setup]
        end

        if params[:stream].present?
          conditions << "match_casts.cast_stream_id IN (?)"
          conditions_params << params[:stream]
        end

        if params[:channel].present?
          conditions << "match_casts_channels.channel_id IN (?)"
          conditions_params << params[:channel]
        end

        if params[:managers].present?
          conditions << "tournaments.owner_id IN (?)"
          conditions_params << params[:managers]
        end

        if params[:main_participants].present?
          conditions << "tournament_main_participants.user_id IN (?)"
          conditions_params << params[:main_participants]
        end

        if params[:media_representatives].present?
          conditions << "tournament_media_representatives.user_id IN (?)"
          conditions_params << params[:media_representatives]
        end

        if params[:staff_members].present?
          conditions << "match_staff_members.user_id IN (?)"
          conditions_params << params[:staff_members]
        end

        if params[:analytics].present?
          conditions << "match_analytics.user_id IN (?)"
          conditions_params << params[:analytics]
        end

        if params[:commentators].present?
          conditions << "match_commentators.user_id IN (?)"
          conditions_params << params[:commentators]
        end

        if params[:backup_commentators].present?
          conditions << "match_backup_commentators.user_id IN (?)"
          conditions_params << params[:backup_commentators]
        end

        if params[:host_analytic].present?
          conditions << "match_host_analytics.user_id IN (?)"
          conditions_params << params[:host_analytic]
        end

        query = conditions.join(" OR ")

        where(query, *conditions_params)
      }

      scope :sort_by_top, -> { order('tournaments.top') }
      scope :sort_by_date, -> { order(:start_at) }
      scope :matches_with_dates, -> { where('matches.start_at IS NOT NULL') }

      scope :only_visible, -> { where(visible: true).where('tournaments.visible': true) }
      scope :only_visible_join_tournament, -> {
        joins(:tournament).where(visible: true).where('tournaments.visible': true)
      }
    end

  end
end

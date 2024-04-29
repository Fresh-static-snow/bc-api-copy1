# frozen_string_literal: true

module CorporateModule
  module Scopes

    extend ActiveSupport::Concern

    included do
      scope :filter_by_focused_date, -> (focused_date) {
        where('start_at = ? OR (? between start_at AND end_at)', focused_date.in_time_zone, focused_date.in_time_zone)
      }

      scope :filter_by_period_from, -> (period_from) {
        where('end_at >= ?', period_from.in_time_zone)
      }

      scope :filter_by_period_to, -> (period_to) {
        where('start_at <= ?', period_to.in_time_zone)
      }

      scope :filter_by_main_participants, -> (main_participants_id) {
        where('corporate_main_participants.user_id': main_participants_id)
      }
      scope :filter_by_media_representatives, -> (media_representative_id) {
        where('corporate_participants.user_id': media_representative_id)
      }
      scope :filter_by_staff_members, -> (staff_members_id) {
        where('corporate_participants.user_id': staff_members_id)
      }
      scope :filter_by_analytics, -> (analytics_id) {
        where('corporate_participants.user_id': analytics_id)
      }
      scope :filter_by_commentators, -> (commentator_id) {
        where('corporate_participants.user_id': commentator_id)
      }

      scope :filter_by_params, -> (params) {
        conditions = []
        conditions_params = []

        if params[:main_participants].present?
          conditions << "corporate_main_participants.user_id IN (?)"
          conditions_params << params[:main_participants]
        end

        if params[:media_representatives].present?
          conditions << "corporate_participants.user_id IN (?)"
          conditions_params << params[:media_representatives]
        end

        if params[:staff_members].present?
          conditions << "corporate_participants.user_id IN (?)"
          conditions_params << params[:staff_members]
        end

        if params[:analytics].present?
          conditions << "corporate_participants.user_id IN (?)"
          conditions_params << params[:analytics]
        end

        if params[:commentators].present?
          conditions << "corporate_participants.user_id IN (?)"
          conditions_params << params[:commentators]
        end

        query = conditions.join(" OR ")

        where(query, *conditions_params)
      }

      scope :sort_by_date, -> { order(:start_at) }
      scope :only_visible, -> { where(visible: true) }
    end

  end
end

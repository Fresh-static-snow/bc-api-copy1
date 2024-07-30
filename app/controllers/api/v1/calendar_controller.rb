# frozen_string_literal: true

module Api
  module V1
    class CalendarController < ApplicationController

      def index
        authorize Calendar, view_mode

        data = Calendar::List.call(calendar_params, current_user)
        render_json_response(true, data, :ok)
      end

      def filters
        data = Calendar::Filter.call(search_params)

        render_json_response(true, data, :ok)
      end

      private

      def view_mode
        @view_mode = Calendar::List::VIEW_MODES.first
        if calendar_params[:scope].present? && Calendar::List::VIEW_MODES.include?(calendar_params[:scope].to_sym)
          @view_mode = calendar_params[:scope].to_sym
        end
      end

      def calendar_params
        params.permit(
          :period_from,
          :period_to,
          :focused_date,
          :scope,
          game_discipline: [],
          studio: [],
          analytic_studio: [],
          setup: [],
          stream: [],
          channel: [],
          managers: [],
          main_participants: [],
          media_representatives: [],
          staff_members: [],
          analytics: [],
          commentators: [],
          current_user: []
        )
      end

      def search_params
        params.permit(:scope, :term)
      end

    end
  end
end

# frozen_string_literal: true

require 'google/apis/calendar_v3'

module GoogleApi
  module CalendarV3
    class Base

      attr_reader :token, :event_params

      def initialize(token, event_params)
        @token = token
        @event_params = event_params
      end

      private

      def calculate_start_and_end_times # rubocop:disable Metrics/AbcSize
        start_at = if event_params[:start_at].present?
                     event_params[:start_at].to_s(:iso8601)
                   else
                     Time.current.to_s(:iso8601)
                   end
        end_at = if event_params[:end_at].present?
                   event_params[:end_at].to_s(:iso8601)
                 else
                   (Time.zone.parse(start_at) + 1.hour).to_s(:iso8601)
                 end

        [start_at, end_at]
      end

      def calendar
        @calendar ||= create_calendar
      end

      def calendar_id
        'primary'
      end

      def create_calendar
        calendar = Google::Apis::CalendarV3::CalendarService.new
        calendar.authorization = access_token
        calendar
      end

      def access_token
        access_token = token.access_token
        access_token = refresh_access_token(token) if token_expired?(token)
        access_token
      end

      def token_expired?(token)
        expiration_time = Time.zone.at(token.expires_at.to_i)
        Time.zone.now >= expiration_time
      end

      def refresh_access_token(token)
        GoogleApi::CalendarV3::RefreshToken.call(token)
      end

    end
  end
end

# frozen_string_literal: true

module GoogleApi
  module CalendarV3
    class Create < Base

      def self.call(token, event_params)
        new(token, event_params).call
      end

      def call # rubocop:disable Metrics/AbcSize
        start_at, end_at = calculate_start_and_end_times

        event = Google::Apis::CalendarV3::Event.new(
          summary: event_params[:title],
          description: event_params[:description],
          start: Google::Apis::CalendarV3::EventDateTime.new(date_time: start_at, time_zone: event_params[:time_zone]),
          end: Google::Apis::CalendarV3::EventDateTime.new(date_time: end_at, time_zone: event_params[:time_zone])
        )

        begin
          res = calendar.insert_event(calendar_id, event)
          res&.id
        rescue Google::Apis::ClientError => e
          Sentry.capture_exception(e)
          nil
        end
      end

    end
  end
end

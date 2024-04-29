# frozen_string_literal: true

module GoogleApi
  module CalendarV3
    class Update < Base

      attr_reader :event_id

      def self.call(event_id, token, event_params)
        new(event_id, token, event_params).call
      end

      def initialize(event_id, token, event_params)
        super(token, event_params)
        @event_id = event_id
      end

      def call # rubocop:disable Metrics/AbcSize
        begin
          event = calendar.get_event(calendar_id, event_id)
        rescue Google::Apis::ClientError
          event = false
          event
        end

        if event.present?
          start_at, end_at = calculate_start_and_end_times

          event.summary = event_params[:title]
          event.description = event_params[:description]
          event.start = Google::Apis::CalendarV3::EventDateTime.new(
            date_time: start_at, time_zone: event_params[:time_zone]
          )
          event.end = Google::Apis::CalendarV3::EventDateTime.new(
            date_time: end_at, time_zone: event_params[:time_zone]
          )

          begin
            res = calendar.update_event(calendar_id, event_id, event)
            res&.id
          rescue Google::Apis::ClientError
            nil
          end
        end
      end

    end
  end
end

# frozen_string_literal: true

module GoogleApi
  module CalendarV3
    class Delete < Base

      attr_reader :event_id, :token

      def self.call(event_id, token)
        new(event_id, token).call
      end

      def initialize(event_id, token)
        super(token, nil)
        @event_id = event_id
      end

      def call
        calendar.delete_event(calendar_id, event_id)
      rescue Google::Apis::ClientError => e
        Sentry.capture_exception(e)
        nil
      end

    end
  end
end

# frozen_string_literal: true

module GoogleApi
  module CalendarV3
    class GetAuthLink

      def self.call
        new.call
      end

      def call
        args = {
          client_id: ENV.fetch('GOOGLE_CLIENT_ID'),
          response_type: 'code',
          scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar https://www.googleapis.com/auth/spreadsheets',
          redirect_uri: Rails.application.routes.url_helpers.api_v1_google_calendar_oauth_callback_url,
          access_type: 'offline',
          prompt: 'consent'
        }

        "https://accounts.google.com/o/oauth2/v2/auth?#{args.to_query}"
      end

    end
  end
end

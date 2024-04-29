# frozen_string_literal: true

module GoogleApi
  module CalendarV3
    class RefreshToken

      attr_reader :token

      def self.call(token)
        new(token).call
      end

      def initialize(token)
        @token = token
      end

      def call # rubocop:disable Metrics/AbcSize
        refresh_token = token&.refresh_token
        return false unless refresh_token

        uri = URI.parse('https://www.googleapis.com/oauth2/v4/token')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(uri.path)

        query = {
          client_id: ENV.fetch('GOOGLE_CLIENT_ID'),
          client_secret: ENV.fetch('GOOGLE_CLIENT_SECRET'),
          refresh_token: refresh_token,
          grant_type: 'refresh_token'
        }
        request.set_form_data(query)

        response = http.request(request)
        data = JSON.parse(response.body)
        if response.code == '200'
          token.access_token = data["access_token"]
          token.expires_at = Time.current + data["expires_in"]
          token.save

          data["access_token"]
        end
      end

    end
  end
end

# frozen_string_literal: true

module GoogleApi
  module CalendarV3
    class OauthCallback

      attr_reader :params, :user

      def self.call(params, user)
        new(params, user).call
      end

      def initialize(params, user)
        @params = params
        @user = user
      end

      def call # rubocop:disable Metrics/AbcSize
        uri = URI.parse('https://www.googleapis.com/oauth2/v4/token')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(uri.path)

        query = {
          code: params[:code],
          client_id: ENV.fetch('GOOGLE_CLIENT_ID'),
          client_secret: ENV.fetch('GOOGLE_CLIENT_SECRET'),
          redirect_uri: Rails.application.routes.url_helpers.api_v1_google_calendar_oauth_callback_url,
          grant_type: 'authorization_code'
        }
        request.set_form_data(query)

        response = http.request(request)
        data = JSON.parse(response.body)

        if get_user_email(data["access_token"]) != user.email
          return {
            success: false,
            data: 'Google oAuth email doesnt equals to current user email',
            status: 422
          }
        end

        if response.code == '200'
          user_api_token = user.user_api_token || UserApiToken.new(user: user)
          user_api_token.access_token = data["access_token"]
          user_api_token.refresh_token = data["refresh_token"]
          user_api_token.expires_at = Time.current + data["expires_in"]
          user_api_token.save

          {
            success: true,
            data: data,
            status: 200
          }
        else
          {
            success: false,
            data: data,
            status: response.code
          }
        end
      end

      def get_user_email(access_token)
        uri = URI.parse('https://www.googleapis.com/oauth2/v2/userinfo')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.path)
        request['Authorization'] = "Bearer #{access_token}"

        response = http.request(request)
        data = JSON.parse(response.body)

        data["email"] if response.code == '200'
      end

    end
  end
end

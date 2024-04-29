# frozen_string_literal: true

module Api
  module V1
    class GoogleCalendarController < ActionController::API

      def oauth
        redirect_to GoogleApi::CalendarV3::GetAuthLink.call
      end

      def callback
        response = GoogleApi::CalendarV3::OauthCallback.call(params, current_user)

        RunAfterUserAddCalendarJob.perform_later(current_user) if response[:success] == true

        redirect_to "#{ENV.fetch('BASE_FRONT_URL', 'http://localhost:9000')}/account?success=#{response[:success]}"
      end

      def add_calendar_access
        authorize current_user

        data = User::AddCalendarAccess.call(current_user, calendar_access_params)
        render_json_response(true, data, :ok)
      end

      private

      def calendar_access_params
        params.permit(:access_token, :refresh_token)
      end

    end
  end
end

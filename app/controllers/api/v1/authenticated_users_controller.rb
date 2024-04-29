# frozen_string_literal: true

module Api
  module V1
    class AuthenticatedUsersController < ApplicationController

      def authenticated
        authorize current_user

        data = User::Show.call(current_user)
        render_json_response(true, data, :ok)
      end

      def authenticated_notifications
        authorize current_user

        data = User::Notifications.call(current_user, notify_params.merge(scope: 'account'))
        render_json_response(true, data, :ok)
      end

      def notifications_count
        authorize current_user

        data = User::NotificationsCount.call(current_user, { scope: 'account' })
        render_json_response(true, data, :ok)
      end

      private

      def notify_params
        params.permit(:page, :per_page, :start_id)
      end

    end
  end
end

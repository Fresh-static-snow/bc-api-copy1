# frozen_string_literal: true

module Api
  module V1
    class UserNotificationsController < ApplicationController

      def notifications
        authorize user

        data = User::Notifications.call(user, notify_params.merge(scope: 'account'))
        render_json_response(true, data, :ok)
      end

      def mark_as_read
        UserNotification::MarkAsRead.call(current_user, resource_params[:id] || :all)

        render_json_response(true, nil, :ok)
      end

      private

      def user
        @user = User.find(params[:id])
      end

      def resource_params
        params.permit(
          :id
        )
      end

    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class AccountSettingsController < BaseCrudController

      private

      def resource_class
        AccountSetting
      end

      def resource_params
        params.permit(
          :current_user_filter_enabled,
          :default_calendar_scope
        )
      end

      def resource
        @resource = current_user.account_setting
      end

    end
  end
end

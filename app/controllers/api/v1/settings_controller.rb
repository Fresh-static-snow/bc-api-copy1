# frozen_string_literal: true

module Api
  module V1
    class SettingsController < BaseCrudController

      private

      def resource_class
        Setting
      end

      def resource_params
        params.permit(
          :match_duration
        )
      end

      def resource
        @resource = resource_class.find(1)
      end

    end
  end
end

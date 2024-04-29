# frozen_string_literal: true

module Api
  module V1
    class BrandingController < BaseCrudController

      def main
        authorize Branding

        resource = Branding.where(visible: true).first

        data = resource ? Branding::Show.call(resource) : []
        render_json_response(true, data, :ok)
      end

      def change
        authorize Branding

        data = Branding::ChangeMain.call(change_params)
        render_json_response(true, data, :ok)
      end

      private

      def resource_class
        Branding
      end

      def search_params
        params.permit(:term, :scope, :with_history)
      end

      def change_params
        params.permit(
          :id
        )
      end

      def resource_params
        params.permit(
          :id,
          :name,
          :logo,
          :favicon
        )
      end

    end
  end
end

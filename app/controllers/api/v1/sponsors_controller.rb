# frozen_string_literal: true

module Api
  module V1
    class SponsorsController < BaseCrudController

      private

      def resource_class
        Sponsor
      end

      def search_params
        params.permit(:term, :scope, :with_history)
      end

      def resource_params
        params.permit(
          :id,
          :name
        )
      end

    end
  end
end

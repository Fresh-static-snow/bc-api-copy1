# frozen_string_literal: true

module Api
  module V1
    class RegionsController < BaseCrudController

      def destroy
        authorize resource

        data = resource_class::Delete.call(resource)
        handle_entity_result(data, :ok)
      end

      private

      def resource_class
        Region
      end

      def search_params
        params.permit(:term)
      end

      def resource_params
        params.permit(
          :id,
          :code,
          :name
        )
      end

    end
  end
end

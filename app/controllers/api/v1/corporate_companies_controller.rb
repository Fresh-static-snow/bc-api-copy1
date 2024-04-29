# frozen_string_literal: true

module Api
  module V1
    class CorporateCompaniesController < BaseCrudController

      def destroy
        authorize resource

        data = resource_class::Delete.call(resource)
        handle_entity_result(data, :ok)
      end

      private

      def resource_class
        CorporateCompany
      end

      def search_params
        params.permit(:scope, :term)
      end

      def resource_params
        params.permit(
          :id,
          :title,
          :keyword,
          :cover
        )
      end

    end
  end
end

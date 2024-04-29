# frozen_string_literal: true

module Api
  module V1
    class UserCompaniesController < BaseCrudController

      def create
        authorize resource_class

        data = resource_class::Create.call(resource_params, current_user)
        handle_entity_result(data, :ok)
      end

      def update
        authorize resource

        data = resource_class::Update.call(resource, resource_params, current_user)
        handle_entity_result(data, :ok)
      end

      def destroy
        authorize resource

        data = resource_class::Delete.call(resource, current_user)
        handle_entity_result(data, :ok)
      end

      private

      def resource_class
        UserCompany
      end

      def search_params
        params.permit(:scope, :term)
      end

      def resource_params
        params.permit(
          :id,
          :title,
          :cover,
          user_ids: []
        )
      end

    end
  end
end

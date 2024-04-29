# frozen_string_literal: true

module Api
  module V1
    class RolesController < BaseCrudController

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

        role_users = resource.users
        data = resource_class::Delete.call(resource, current_user)

        role_users.map do |u|
          sign_out(u) if u.roles.length == 1
        end

        handle_entity_result(data, :ok)
      end

      def permissions
        authorize Role, :index?

        data = Role::Permissions.call(search_params)
        render_json_response(true, data, :ok)
      end

      private

      def resource_class
        Role
      end

      def search_params
        params.permit(:term)
      end

      def resource_params
        params.permit(
          :id,
          :title,
          :description,
          permissions: []
        )
      end

    end
  end
end

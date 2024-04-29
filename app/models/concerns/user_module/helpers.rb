# frozen_string_literal: true

module UserModule
  module Helpers

    extend ActiveSupport::Concern

    included do
      def superadmin?
        id == 1 || email == 'autotests@maincast.com'
      end

      def permission?(model_name, action_name) # rubocop:disable Metrics/AbcSize
        return true if superadmin?
        return false if _permissions.blank?

        permission = _permissions[model_name]
        return false if permission.blank?

        return false if permission[:deny]&.include?(:all) || permission[:deny]&.include?(action_name)
        return true if permission[:grant]&.include?(:all) || permission[:grant]&.include?(action_name)

        false
      end

      private

      def _permissions
        return [] if _permissions_from_roles.blank?

        _permissions_from_roles
      end

      def _permissions_from_roles
        @_permissions_from_roles ||= Rails.cache.fetch('permissions_from_roles', expires_in: 1.second) do
          PermissionService.generate_user_permissions(roles)
        end
      end
    end

  end
end

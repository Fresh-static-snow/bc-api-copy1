# frozen_string_literal: true

class Role
  class Update < Base

    include SendNotify

    attr_reader :resource, :role_params, :current_user

    def self.call(resource, role_params, current_user)
      new(resource, role_params, current_user).call
    end

    def call
      with_transaction do
        update_role
      end

      collect_errors(resource)

      send_admin_notify(resource, :update, false)

      resource
    end

    private

    def initialize(resource, role_params, current_user)
      @resource = resource
      @role_params = role_params
      @current_user = current_user

      super()
    end

    def update_role
      resource.update(
        role_params.except(:permissions).merge(
          permissions: PermissionService.special_permissions_by_ids(role_params[:permissions])
        )
      )
    end

  end
end

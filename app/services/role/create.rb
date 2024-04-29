# frozen_string_literal: true

class Role
  class Create < Base

    include SendNotify

    attr_accessor :resource

    def self.call(role_params, current_user)
      new(role_params, current_user).call
    end

    def call
      with_transaction do
        create_role
      end

      collect_errors(resource)

      send_admin_notify(resource, :create, false)

      resource
    end

    private

    attr_reader :role_params, :current_user

    def initialize(role_params, current_user)
      @role_params = role_params
      @current_user = current_user

      super()
    end

    def create_role
      @resource = Role.create(
        role_params.except(:permissions).merge(
          permissions: PermissionService.special_permissions_by_ids(role_params[:permissions])
        )
      )
    end

  end
end

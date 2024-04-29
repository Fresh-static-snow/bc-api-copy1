# frozen_string_literal: true

class User
  class Update < Base

    include SendNotify

    attr_reader :resource, :params, :current_user

    def self.call(resource, params, current_user)
      new(resource, params, current_user).call
    end

    def initialize(resource, params, current_user)
      @resource = resource
      @params = params
      @current_user = current_user

      super()
    end

    def call
      with_transaction do
        update_resource
      end

      collect_errors(resource)

      send_admin_notify(resource, :update, false)

      resource
    end

    private

    def update_resource
      destroy_deleted_items

      if params[:avatar] == ""
        resource&.avatar&.purge
        resource.update(params.except(:avatar))
      else
        resource.update(params)
      end
    end

    def destroy_deleted_items
      UserRole.only_deleted.where(user_id: resource.id).find_each(&:destroy_fully!)
      UserDisciplineMembership.only_deleted.where(user_id: resource.id).find_each(&:destroy_fully!)
    end

  end
end

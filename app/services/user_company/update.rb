# frozen_string_literal: true

class UserCompany
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
      if params[:cover].blank?
        resource&.cover&.purge
        resource.update(params.except(:cover))
      else
        resource.update(params)
      end
    end

  end
end

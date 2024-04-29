# frozen_string_literal: true

class UserCompany
  class Create < Base

    include SendNotify

    attr_reader :resource, :params, :current_user

    def self.call(params, current_user)
      new(params, current_user).call
    end

    def initialize(params, current_user)
      @params = params
      @current_user = current_user

      super()
    end

    def call
      with_transaction do
        create_resource
      end

      collect_errors(resource)

      send_admin_notify(resource, :create, false)

      resource
    end

    private

    def create_resource
      @resource = UserCompany.create(params)
    end

  end
end

# frozen_string_literal: true

class UserCompany
  class Delete < Base

    include SendNotify

    attr_accessor :resource, :current_user

    def self.call(resource, current_user)
      new(resource, current_user).call
    end

    def initialize(resource, current_user)
      @resource = resource
      @current_user = current_user

      super()
    end

    def call
      with_transaction do
        delete_resource
      end

      collect_errors(resource)

      send_admin_notify(resource, :destroy, false)

      resource
    end

    private

    def delete_resource
      resource.users.with_deleted.update_all(company_id: nil) # rubocop:disable Rails/SkipsModelValidations
      resource.destroy_fully!
    end

  end
end

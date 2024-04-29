# frozen_string_literal: true

class Corporate
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
      current_user_ids = Corporate::Participants.call(resource)

      with_transaction do
        delete_resource
      end

      collect_errors(resource)

      unless resource.errors.any?
        send_notify(resource, current_user_ids, :destroy, :deleted)
        send_admin_notify(resource, :destroy, true)
      end

      resource
    end

    private

    def delete_resource
      resource.destroy_fully!
    end

  end
end

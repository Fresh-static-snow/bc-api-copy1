# frozen_string_literal: true

class Corporate
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

      notify unless resource.errors.any?

      resource
    end

    def create_resource
      params[:participant_ids] = params[:participant_ids].uniq if params[:participant_ids].present?
      @resource = Corporate.create(params)
    end

    def notify
      added_user_ids = Corporate::AddedParticipants.call(resource)
      send_notify(resource, added_user_ids, :create, :added)
      send_admin_notify(resource, :create, true)
    end

  end
end

# frozen_string_literal: true

class Tournament
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

    private

    def notify
      added_user_ids = Tournament::AddedParticipants.call(resource)
      send_notify(resource, added_user_ids, :create, :added)
      send_admin_notify(resource, :create, true)

      BotsNotifyJob.perform_later(User.managment_staff.to_a, resource, tournament_message_text(:create), :create)
    end

    def create_resource
      @resource = Tournament.create(params)
    end

  end
end

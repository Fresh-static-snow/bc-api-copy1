# frozen_string_literal: true

class Match
  class SoftDestroy < Base

    include SendNotify

    attr_accessor :resource, :current_user, :bulk

    def self.call(resource, current_user, bulk: false)
      new(resource, current_user, bulk).call
    end

    def initialize(resource, current_user, bulk)
      @resource = resource
      @current_user = current_user
      @bulk = bulk
    end

    def call # rubocop:disable Metrics/AbcSize
      Match::RunBeforeDestroyJob.perform_later(resource)

      current_user_ids = Match::Cast.call(resource)

      with_transaction do
        bulk ? resource.destroy_all : resource.destroy
        @errors = {}
      end

      bulk ? collect_errors(*resource.with_deleted) : collect_errors(resource)

      unless resource.errors.any?
        send_notify(resource, current_user_ids, :destroy, :deleted)
        send_admin_notify(resource, :destroy, true)
      end

      bulk ? resource.with_deleted : resource
    end

  end
end

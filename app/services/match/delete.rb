# frozen_string_literal: true

class Match
  class Delete < Base

    attr_accessor :resource, :current_user, :bulk

    def self.call(resource, current_user, bulk: false)
      new(resource, current_user, bulk).call
    end

    def initialize(resource, current_user, bulk)
      @resource = resource
      @current_user = current_user
      @bulk = bulk
    end

    def call
      with_transaction do
        delete_resource
        @errors = {}
      end

      bulk ? collect_errors(*resource.with_deleted) : collect_errors(resource)

      resource
    end

    private

    def delete_resource
      bulk ? resource.find_each(&:destroy_fully!) : resource.destroy_fully!
    end

  end
end

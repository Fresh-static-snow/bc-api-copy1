# frozen_string_literal: true

class Team
  class Delete < Base

    attr_accessor :resource

    def self.call(resource)
      new(resource).call
    end

    def initialize(resource)
      @resource = resource

      super()
    end

    def call
      with_transaction do
        delete_resource
      end

      collect_errors(resource)

      resource
    end

    private

    def delete_resource
      Match.with_deleted.where(team_one_id: resource.id).update_all(team_one_id: nil) # rubocop:disable Rails/SkipsModelValidations
      Match.with_deleted.where(team_two_id: resource.id).update_all(team_two_id: nil) # rubocop:disable Rails/SkipsModelValidations
      resource.destroy_fully!
    end

  end
end

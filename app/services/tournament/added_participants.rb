# frozen_string_literal: true

class Tournament
  class AddedParticipants < Base

    attr_reader :resource

    def self.call(resource)
      new(resource).call
    end

    def initialize(resource)
      @resource = resource

      super()
    end

    def call
      changed_ids
    end

    def changed_records
      association_records_list.flatten.uniq
    end

    private

    def changed_ids # rubocop:disable Metrics/AbcSize
      added_user_ids = []

      if resource.visible
        added_user_ids << resource.owner_id if resource.owner_id.present?

        resource.tournament_media_representatives.map do |m|
          added_user_ids << m.user_id
        end

        resource.tournament_main_participants.map do |m|
          added_user_ids << m.user_id
        end
      end

      added_user_ids.uniq
    end

  end
end

# frozen_string_literal: true

class Corporate
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

    private

    def changed_ids # rubocop:disable Metrics/AbcSize
      added_user_ids = []
      if resource.visible == true
        resource.corporate_main_participants.map do |m|
          added_user_ids << m.saved_changes[:user_id][1] if m.saved_changes[:user_id].present?
        end

        resource.corporate_participants.map do |m|
          added_user_ids << m.saved_changes[:user_id][1] if m.saved_changes[:user_id].present?
        end

        added_user_ids = added_user_ids.uniq
      end

      added_user_ids
    end

  end
end

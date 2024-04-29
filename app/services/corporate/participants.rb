# frozen_string_literal: true

class Corporate
  class Participants < Base

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

    def changed_ids
      current_user_ids = []
      if resource.visible == true
        resource.corporate_main_participants.map do |m|
          current_user_ids << m.user_id
        end

        resource.corporate_participants.map do |m|
          current_user_ids << m.user_id
        end

        current_user_ids = current_user_ids.uniq
      end

      current_user_ids
    end

  end
end

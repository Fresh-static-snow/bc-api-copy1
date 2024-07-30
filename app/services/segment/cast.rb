# frozen_string_literal: true

class Segment
  class Cast < Match::Cast

    attr_reader :resource

    def self.call(resource)
      new(resource).call
    end

    def initialize(resource)
      @resource = resource

      super()
    end

    def call
      current_user_ids
    end

    private

    def current_user_ids # rubocop:disable Metrics/AbcSize
      added_user_ids = []

      if resource.visible == true && resource.tournament.visible == true
        added_user_ids = resource.match_casts.flat_map do |match_casts|
          [
            match_casts.match_analytics,
            match_casts.match_commentators,
            match_casts.match_staff_members
          ].flat_map { |association| association.map(&:user_id) }.compact
        end.uniq
      end

      added_user_ids
    end

  end
end

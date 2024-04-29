# frozen_string_literal: true

class Tournament
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

    def changed_ids # rubocop:disable Metrics/AbcSize
      current_user_ids = []

      if resource.visible == true
        current_user_ids << resource.owner_id if resource.owner_id.present?

        resource.tournament_media_representatives.map do |m|
          current_user_ids << m.user_id
        end

        resource.tournament_main_participants.map do |m|
          current_user_ids << m.user_id
        end

        resource.matches.map do |m|
          next if m.visible == false

          m.match_casts.map do |cast|
            cast.match_analytics.map do |a|
              current_user_ids << a.user_id
            end

            cast.match_commentators.map do |a|
              current_user_ids << a.user_id
            end

            cast.match_staff_members.map do |a|
              current_user_ids << a.user_id
            end
          end
        end

        current_user_ids = current_user_ids.uniq
      end

      current_user_ids
    end

  end
end

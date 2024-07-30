# frozen_string_literal: true

class Match
  class AddedCast < Base

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
      association_records_list.flatten.compact.uniq
    end

    private

    def changed_ids # rubocop:disable Metrics/AbcSize
      return [] unless resource.visible && resource.tournament.visible

      association_records_list.flat_map do |association|
        association.map { |item| item.saved_changes[:user_id][1] if item && item.saved_changes[:user_id].present? }
      end.compact
    end

    def association_records_list
      resource.match_casts.flat_map do |match_casts|
        [
          match_casts.match_analytics,
          match_casts.match_commentators,
          match_casts.match_staff_members,
          match_casts.reload.match_backup_commentators,
          [match_casts.reload.match_host_analytic]
        ]
      end
    end

  end
end

# frozen_string_literal: true

class GameDiscipline
  class Restore < BaseRestoreService

    include ArchivedCover

    def call # rubocop:disable Metrics/AbcSize
      with_transaction do
        resource.recover
        recover_cover(resource) if archived_cover(resource)

        resource.tournaments.each do |t|
          recover_cover(t) if archived_cover(t)
        end
      end

      resource.tournaments.each do |t|
        Tournament::RunAfterUpdateJob.perform_later(t)
      end

      collect_errors(resource)

      resource
    end

  end
end

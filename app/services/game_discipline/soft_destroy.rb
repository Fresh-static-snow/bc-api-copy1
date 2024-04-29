# frozen_string_literal: true

class GameDiscipline
  class SoftDestroy < BaseSoftDestroyService

    include ArchivedCover

    def call # rubocop:disable Metrics/AbcSize
      resource.tournaments.each do |t|
        Tournament::RunBeforeDestroyJob.perform_now(t)
      end

      with_transaction do
        cache_cover(resource) if resource.cover.attached?

        resource.tournaments.each do |t|
          cache_cover(t) if t.cover.attached?
        end

        resource.destroy
      end

      collect_errors(resource)

      resource
    end

  end
end

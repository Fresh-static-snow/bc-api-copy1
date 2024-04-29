# frozen_string_literal: true

class Match
  class Restore < Base

    include ArchivedCover
    include SendNotify

    attr_reader :resource, :current_user, :bulk, :discipline

    def self.call(resource, current_user, bulk: false)
      new(resource, current_user, bulk).call
    end

    def initialize(resource, current_user, bulk)
      @resource = bulk ? resource : [resource]
      @current_user = current_user
      @bulk = bulk
    end

    def call # rubocop:disable Metrics/AbcSize
      @tournament_id = resource&.map(&:tournament_id)&.uniq

      return if @tournament_id.length > 1

      with_transaction do
        unless resource&.any? { |res| !res.deleted? }
          recover_discipline
          recover_tournament
          resource&.each(&:recover)
          @errors = {}
        end
      end

      collect_errors(*resource)

      resource&.each do |match|
        next if match.deleted?

        current_user_ids = Match::Cast.call(match)
        send_notify(match, current_user_ids, :create, :added)
        send_admin_notify(match, :create, true)

        Match::RunAfterCreateJob.perform_later(match)
      end

      resource
    end

    private

    def recover_tournament
      if tournament.deleted?
        tournament.recover(recursive: false)
        recover_cover(tournament) if archived_cover(tournament)
      end
    end

    def recover_discipline
      @discipline = GameDiscipline.only_deleted.find_by(id: tournament.game_discipline_id)

      if discipline&.deleted?
        discipline.recover(recursive: false)

        recover_cover(discipline) if archived_cover(discipline)
      end
    end

    def tournament
      @tournament ||= Tournament.with_deleted.find_by(id: @tournament_id.first)
    end

  end
end

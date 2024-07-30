# frozen_string_literal: true

module ManagementContext
  module Items
    class DeletedItems < BaseListService

      AVAILABLE_SCOPES = ['only_deleted'].freeze

      class << self

        def call(resource_class)
          case resource_class.name
          when 'GameDiscipline'
            disciplines_object
          when 'Tournament'
            tournaments_object
          when 'Match'
            tournament_matches_object
          when 'Segment'
            tournament_segments_object
          else
            default_object(resource_class)
          end
        end

        private

        def default_object(resource_class)
          resource_class.only_deleted
        end

        def disciplines_object
          disciplines&.map do |discipline|
            {
              id: discipline.id,
              title: discipline.title,
              tournaments: tournaments_object(tournament: discipline.tournaments.with_deleted)
            }
          end
        end

        def tournaments_object(tournament: Tournament)
          tournament
            .with_deleted
            .joins("LEFT JOIN matches ON matches.tournament_id = tournaments.id AND matches.deleted_at IS NOT NULL")
            .where("tournaments.deleted_at IS NOT NULL")
            .order("tournaments.start_at")
            .distinct&.map do |tournament_object|
              {
                id: tournament_object.id,
                title: tournament_object.title,
                matches: matches_object(tournament_object),
                deleted: tournament_object.deleted_at
              }
            end
        end

        def tournament_matches_object(tournament: Tournament)
          tournament
            .with_deleted
            .joins("LEFT JOIN matches ON matches.tournament_id = tournaments.id AND matches.deleted_at IS NOT NULL")
            .where("matches.deleted_at IS NOT NULL")
            .distinct&.map do |tournament_object|
            {
              id: tournament_object.id,
              title: tournament_object.title,
              matches: matches_object(tournament_object)
            }
          end
        end

        def tournament_segments_object(tournament: Tournament)
          tournament
            .with_deleted
            .joins("LEFT JOIN matches ON matches.tournament_id = tournaments.id AND matches.deleted_at IS NOT NULL")
            .where("matches.deleted_at IS NOT NULL")
            .where("matches.type = 'Segment'")
            .distinct&.map do |tournament_object|
            {
              id: tournament_object.id,
              title: tournament_object.title,
              matches: segments_object(tournament_object)
            }
          end
        end

        def segments_object(tournament)
          Segment
            .only_deleted
            .where(tournament_id: tournament.id)
            .order(:start_at)
            .distinct&.map do |segment|
              {
                id: segment.id,
                title: segment.title,
                type: segment.type,
                tournament_name: tournament.title
              }
            end
        end

        def matches_object(tournament) # rubocop:disable Metrics/AbcSize
          Match
            .only_deleted
            .includes(:team_one, :team_two)
            .where(type: %w[Match Segment])
            .where(tournament_id: tournament.id)
            .order(:start_at)
            .distinct&.map do |match|
              {
                id: match.id,
                tournament_name: tournament.title,
                type: match.type,
                title: match.title,
                team_one_name: match.team_one&.name || 'TBD',
                team_two_name: match.team_two&.name || "TBD"
              }
            end
        end

        def disciplines
          GameDiscipline
            .only_deleted
            .includes(tournaments: :matches)
            .joins(
              "LEFT JOIN tournaments ON tournaments.game_discipline_id = game_disciplines.id
                                                                    AND tournaments.deleted_at IS NOT NULL"
            )
            .joins("LEFT JOIN matches ON matches.tournament_id = tournaments.id AND matches.deleted_at IS NOT NULL")
            .where(
              "tournaments.deleted_at IS NOT NULL
               OR game_disciplines.deleted_at IS NOT NULL
               OR matches.deleted_at IS NOT NULL"
            )
            .distinct
        end

      end

    end
  end
end

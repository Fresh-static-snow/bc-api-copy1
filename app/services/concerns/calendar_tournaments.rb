# frozen_string_literal: true

module CalendarTournaments

  extend ActiveSupport::Concern

  included do
    private

    def tournaments # rubocop:disable Metrics/AbcSize
      join_includes = [
        {
          matches: [
            :team_one, :team_two,
            { match_casts: [
              # { commentators: { avatar_attachment: :blob } },
              # { analytics: { avatar_attachment: :blob } },
              # { staff_members: { avatar_attachment: :blob } },
              :analytic_studio,
              :language,
              :studio,
              :cast_channels
            ] }
          ]
        },
        { cover_attachment: :blob },
        { main_participants: { avatar_attachment: :blob } },
        { media_representatives: { avatar_attachment: :blob } },
        { game_discipline: { cover_attachment: :blob } },
        :type
      ]

      results = Tournament.includes(*join_includes)
      results = results.only_visible unless current_user.permission?(Tournament.name, :visible)
      results = results.distinct.select(
        'tournaments.id, tournaments.start_at, tournaments.end_at, tournaments.top, tournaments.game_discipline_id,
          tournaments.type_id, tournaments.title, tournaments.ui_template, tournaments.visible'
      ).left_joins(*join_includes)

      results = Tournament.filter(
        calendar_params[:current_user]&.include?('true') ? filter_params_for_current_user : filter_params_for_filter,
        results
      ).sort_by_top.sort_by_date

      group_and_serialize_tournaments(results)
    end

    def group_and_serialize_tournaments(raw_tournaments)
      raw_tournaments.group_by(&:game_discipline).map do |discipline, tournaments|
        {
          discipline: GameDisciplineSerializer.render_as_hash(discipline, view: :list),
          tournaments: group_and_serialize_top_tournaments(tournaments)
        }
      end
    end

    def group_and_serialize_top_tournaments(tournaments)
      tournaments.group_by(&:top).map do |top, top_tournaments|
        {
          tier: top,
          list: top_tournaments.map { |tournament| serialize_tournament(tournament) }
        }
      end
    end

    def serialize_tournament(tournament)
      TournamentSerializer.render_as_hash(tournament, view: view_mode)
    end
  end

end

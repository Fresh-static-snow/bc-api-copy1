# frozen_string_literal: true

module CalendarMatches

  extend ActiveSupport::Concern

  included do
    private

    def matches # rubocop:disable Metrics/AbcSize
      join_includes = [
        :team_one,
        :team_two,
        { tournament: [
          { cover_attachment: :blob },
          { main_participants: { avatar_attachment: :blob } },
          { media_representatives: { avatar_attachment: :blob } },
          { game_discipline: { cover_attachment: :blob } },
          :type
        ] },
        { match_casts: %i[
          analytic_studio
          language
          studio
          setup
          stream
          cast_channels
        ] }
      ]

      results = Match.includes(*join_includes)
                     .joins('LEFT JOIN match_casts ON match_casts.match_id = matches.id')
                     .joins('LEFT JOIN match_commentators ON match_commentators.match_cast_id = match_casts.id')
                     .joins('LEFT JOIN match_backup_commentators ON
                             match_backup_commentators.match_cast_id = match_casts.id')
                     .joins('LEFT JOIN match_host_analytics ON match_host_analytics.match_cast_id = match_casts.id')
                     .joins('LEFT JOIN match_analytics ON match_analytics.match_cast_id = match_casts.id')
                     .joins('LEFT JOIN match_staff_members ON match_staff_members.match_cast_id = match_casts.id')
                     .joins("LEFT JOIN active_storage_attachments AS ast ON (ast.record_type = 'User' AND
                             ast.record_id = match_commentators.user_id) OR (ast.record_type = 'User' AND
                             ast.record_id = match_analytics.user_id) OR (ast.record_type = 'User' AND
                             ast.record_id = match_staff_members.user_id)")
                     .joins("LEFT JOIN active_storage_blobs AS asb ON asb.id = ast.blob_id")
      results = results.distinct.select(
        'matches.visible, matches.team_one_id, matches.team_two_id, matches.start_at, matches.end_at, matches.best_of,
          matches.tournament_id, matches.id, matches.type, matches.title, tournaments.top'
      ).left_joins(*join_includes)

      results = Match.filter(
        calendar_params[:current_user]&.include?('true') ? filter_params_for_current_user : filter_params_for_filter,
        results.sort_by_date
      )

      case view_mode
      when :day
        raw_matches = results.group_by do |m|
          [m.tournament.game_discipline, m.tournament]
        end

        group = raw_matches.each_with_object({}) do |((discipline, tournament), matches), m|
          m[discipline] ||= {}
          m[discipline][tournament] = matches
        end

        group.map { |discipline, tournaments| discipline_with_tournaments(discipline, tournaments) }
      when :week, :month
        raw_matches = results.group_by do |m|
          [m.start_at.to_date, m.tournament.discipline, m.tournament]
        end

        group = raw_matches.each_with_object({}) do |((datetime, discipline, tournament), matches), m|
          m[datetime] ||= {}
          m[datetime][discipline] ||= {}
          m[datetime][discipline][tournament] = matches
        end

        group.map do |datetime, disciplines|
          {
            date: datetime,
            type: :tournament,
            disciplines: disciplines.map do |discipline, tournaments|
              discipline_with_tournaments(discipline, tournaments)
            end
          }
        end
      else
        []
      end
    end

    def discipline_with_tournaments(discipline, tournaments)
      {
        discipline: GameDisciplineSerializer.render_as_hash(discipline, view: :list),
        tournaments: tournaments.map do |tournament, matches|
          result = TournamentSerializer.render_as_hash(tournament, view: view_mode)
          result['matches'] = MatchSerializer.render_as_hash(matches, view: :calendar, current_user: current_user)
          result
        end
      }
    end
  end

end

# frozen_string_literal: true

module ApiTools
  class Tournaments

    API_URL = 'https://tools.gamelife.org/api/'

    def initialize; end

    def fetch_data
      page = 1

      loop do
        tournaments = get_tournaments(page)

        break if tournaments.blank? || tournaments.empty? || page == 5

        tournaments.each do |tournament_data|
          create_tournament(tournament_data)
        end

        page += 1
      end
    end

    private

    def get_tournaments(page)
      uri = URI.join(API_URL, "tournaments.json?page=#{page}")
      response = http_get(uri)
      JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
    end

    def create_tournament(tournament_data) # rubocop:disable Metrics/AbcSize
      return unless %w[Dota2 CSGO VALORANT valorant].include?(tournament_data['discipline']['alias'])

      game_discipline = update_or_create_discipline(tournament_data['discipline'])

      tournament = Tournament.find_or_initialize_by(title: tournament_data['name'])
      tournament.title = tournament_data['name']
      tournament.start_at = tournament_data['start_on']
      tournament.end_at = tournament_data['end_on']
      tournament.game_discipline = game_discipline
      tournament.visible = true
      tournament.region = nil

      region_data = tournament_data['region']
      tournament.region = create_region(region_data) if region_data

      logo_data = tournament_data['league']&.dig('logo')
      if logo_data.present?
        tournament.cover.attach(
          io: URI.parse(logo_data).open,
          filename: "tournament_cover_#{tournament_data['id']}.jpg"
        )
      end

      tournament.save

      fetch_matches(tournament.id, tournament_data['id']) unless tournament.errors.any?
    end

    def update_or_create_discipline(item)
      game_discipline = GameDiscipline.find_or_initialize_by(keyword: item['alias'])
      game_discipline.title = item['name']
      game_discipline.keyword = item['alias']
      game_discipline.order = item['primary_squad_size']
      game_discipline.save

      game_discipline
    end

    def create_region(region_data)
      region = Region.find_or_initialize_by(code: region_data['abbreviation'])
      region.code = region_data['abbreviation']
      region.name = region_data['name']
      region.save

      region
    end

    def fetch_matches(tournament_id, external_id)
      uri = URI.join(API_URL, "tournaments/#{external_id}/matches.json")

      response = http_get(uri)
      matches = if response.is_a?(Net::HTTPSuccess)
                  JSON.parse(response.body)
                else
                  []
                end

      matches.each do |match_data|
        create_match(tournament_id, match_data)
      end
    end

    def create_match(tournament_id, match_data) # rubocop:disable Metrics/AbcSize
      start_at = match_data['start_at']
      best_of = Match.get_best_of_value(match_data['bo_type']&.upcase)

      match = Match.find_or_initialize_by(tournament_id: tournament_id, start_at: start_at)
      match.tournament_id = tournament_id
      match.start_at = start_at if start_at.present?
      match.best_of = best_of
      match.visible = true
      team_one = nil
      team_two = nil
      team_one_data = match_data['player']
      team_two_data = match_data['opponent']

      team_one = create_team(team_one_data) if team_one_data.present?
      team_two = create_team(team_two_data) if team_two_data.present?

      match.team_one = team_one
      match.team_two = team_two

      match.save
    end

    def create_team(team_data)
      discipline = update_or_create_discipline(team_data['discipline'])

      team = Team.find_or_initialize_by(name: team_data['name'], keyword: team_data['tag'])
      team.name = team_data['name']
      team.keyword = team_data['tag']
      team.game_discipline_id = discipline['id']
      team.save

      team
    end

    def http_get(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      access_token = ENV.fetch('API_TOOLS_ACCESS_TOKEN', nil)

      request = Net::HTTP::Get.new(uri.request_uri)
      request['Authorization'] = "Bearer #{access_token}"

      http.request(request)
    end

  end
end

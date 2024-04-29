# frozen_string_literal: true

module ApiTools
  class GameDisciplines

    API_URL = 'https://tools.gamelife.org/api/'

    def initialize; end

    def fetch_data # rubocop:disable Metrics/AbcSize
      uri = URI.join(API_URL, "disciplines.json")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      access_token = ENV.fetch('API_TOOLS_ACCESS_TOKEN', nil)

      request = Net::HTTP::Get.new(uri.request_uri)
      request['Authorization'] = "Bearer #{access_token}"

      response = http.request(request)

      if response.is_a?(Net::HTTPSuccess)
        response = JSON.parse(response.body)

        response.each do |item|
          id = item['id']
          name = item['name']
          keyword = item['alias']
          order = item['primary_squad_size']

          game_discipline = GameDiscipline.find_or_initialize_by(id: id)

          game_discipline.id = id
          game_discipline.title = name
          game_discipline.keyword = keyword
          game_discipline.order = order

          game_discipline.save
        end

        response
      else
        raise "API request failed with status: #{response.code}"
      end
    end

  end
end

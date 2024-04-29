# frozen_string_literal: true

class Tournament
  class Schedule < Base

    def self.call(params, current_user)
      new(params, current_user).call
    end

    def call
      serialized_matches = MatchSerializer.render_as_hash(tournaments.includes(:match_casts),
                                                          view: :schedule,
                                                          current_user: current_user)
      matches_filtration(serialized_matches)
    end

    private

    attr_reader :tournament, :current_user

    def initialize(tournament, current_user = nil)
      @tournament = tournament
      @current_user = current_user
    end

    def tournaments
      @tournaments = tournament&.matches&.sort_by_date&.order(:id)
    end

    def matches_filtration(resources)
      entities_by_date = group_entities_by_date(resources)
      matches = process_entities_by_date(entities_by_date)

      { ui_template: tournament.ui_template, dates: matches }
    end

    def group_entities_by_date(resources)
      resources.group_by { |entity| entity[:start_date] }
    end

    def process_entities_by_date(entities_by_date)
      sorted_entities = entities_by_date.sort_by { |start_date, _| start_date || '0000-00-00' }
      sorted_entities.map do |start_date, entities|
        { start_date: start_date, matches: entities }
      end
    end

  end
end

# frozen_string_literal: true

module MatchContext
  module SetTournament

    extend ActiveSupport::Concern

    included do
      before_save :fill_tournament_id

      def fill_tournament_id
        self.tournament_id = match_cast.match.tournament_id
      end
    end

  end
end

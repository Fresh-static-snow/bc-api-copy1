# frozen_string_literal: true

class Tournament
  class Show < BaseShowService

    def call
      TournamentSerializer.render_as_hash(resource, view: :show)
    end

  end
end

# frozen_string_literal: true

class Tournament
  class Edit < BaseEditService

    def call
      TournamentSerializer.render_as_hash(resource, view: :edit)
    end

  end
end

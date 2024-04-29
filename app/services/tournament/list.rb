# frozen_string_literal: true

class Tournament
  class List < BaseListService

    def call
      only_deleted? ? deleted_resource : TournamentSerializer.render_as_hash(resource.ongoing, view: :list)
    end

  end
end

# frozen_string_literal: true

class GameDiscipline
  class Show < BaseShowService

    def call
      GameDisciplineSerializer.render_as_hash(resource, view: :list)
    end

  end
end

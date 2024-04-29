# frozen_string_literal: true

class GameDiscipline
  class List < BaseListService

    def call
      only_deleted? ? deleted_resource : GameDisciplineSerializer.render_as_hash(resource, view: :list)
    end

  end
end

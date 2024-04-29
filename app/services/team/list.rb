# frozen_string_literal: true

class Team
  class List < BaseListService

    def call
      TeamSerializer.render_as_hash(resource.sort_by_name, view: scope)
    end

  end
end

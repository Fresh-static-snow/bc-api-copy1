# frozen_string_literal: true

class Team
  class Edit < BaseEditService

    def call
      TeamSerializer.render_as_hash(resource, view: :list)
    end

  end
end

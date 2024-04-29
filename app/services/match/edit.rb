# frozen_string_literal: true

class Match
  class Edit < BaseEditService

    def call
      MatchSerializer.render_as_hash(resource, view: :edit)
    end

  end
end

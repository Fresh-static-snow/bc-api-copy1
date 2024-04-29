# frozen_string_literal: true

class UserDiscipline
  class Show < BaseShowService

    def call
      UserDisciplineSerializer.render_as_hash(resource, view: :list)
    end

  end
end

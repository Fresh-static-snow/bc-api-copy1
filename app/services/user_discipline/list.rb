# frozen_string_literal: true

class UserDiscipline
  class List < BaseListService

    def call
      UserDisciplineSerializer.render_as_hash(resource, view: :list)
    end

  end
end

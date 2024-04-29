# frozen_string_literal: true

class UserDiscipline
  class Edit < BaseEditService

    def call
      UserDisciplineSerializer.render_as_hash(resource, view: :list)
    end

  end
end

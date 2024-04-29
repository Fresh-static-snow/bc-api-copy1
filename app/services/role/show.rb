# frozen_string_literal: true

class Role
  class Show < BaseShowService

    def call
      RoleSerializer.render_as_hash(resource, view: :list)
    end

  end
end

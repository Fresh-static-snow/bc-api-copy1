# frozen_string_literal: true

class User
  class Show < BaseShowService

    def call
      UserSerializer.render_as_hash(resource, view: :show)
    end

  end
end

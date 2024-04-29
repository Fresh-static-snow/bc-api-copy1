# frozen_string_literal: true

class User
  class Edit < BaseEditService

    def call
      UserSerializer.render_as_hash(resource, view: :edit)
    end

  end
end

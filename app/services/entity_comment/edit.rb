# frozen_string_literal: true

class EntityComment
  class Edit < BaseEditService

    def call
      EntityCommentSerializer.render_as_hash(resource, view: :list)
    end

  end
end

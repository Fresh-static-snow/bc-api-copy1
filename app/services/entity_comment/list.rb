# frozen_string_literal: true

class EntityComment
  class List < BaseListService

    def call
      EntityCommentSerializer.render_as_hash(resource, view: :list)
    end

  end
end

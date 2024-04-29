# frozen_string_literal: true

class EntityComment
  class Show < BaseShowService

    def call
      EntityCommentSerializer.render_as_hash(resource, view: :list)
    end

  end
end

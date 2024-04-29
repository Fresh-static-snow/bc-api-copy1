# frozen_string_literal: true

class Corporate
  class CommentList < Base

    def self.call(comments)
      new(comments).call
    end

    def call
      EntityCommentSerializer.render_as_hash(@comments, view: :list)
    end

    private

    attr_reader :comments

    def initialize(comments)
      @comments = comments
    end

  end
end

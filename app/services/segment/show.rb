# frozen_string_literal: true

class Segment
  class Show < Match::Show

    def call
      SegmentSerializer.render_as_hash(resource, view: :show, current_user: current_user)
    end

  end
end

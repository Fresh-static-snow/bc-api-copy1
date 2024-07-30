# frozen_string_literal: true

class Segment
  class List < Match::List

    def call
      if only_deleted?
        deleted_resource
      else
        SegmentSerializer.render_as_hash(resource, view: :calendar,
                                                   current_user: current_user)
      end
    end

  end
end

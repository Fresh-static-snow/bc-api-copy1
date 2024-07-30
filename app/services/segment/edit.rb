# frozen_string_literal: true

class Segment
  class Edit < BaseEditService

    def call
      SegmentSerializer.render_as_hash(resource, view: :edit)
    end

  end
end

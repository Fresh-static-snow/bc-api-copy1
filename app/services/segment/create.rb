# frozen_string_literal: true

class Segment
  class Create < Match::Create

    private

    def create_resource
      @resource = Segment.create(params)
    end

  end
end

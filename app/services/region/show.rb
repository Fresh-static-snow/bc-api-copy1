# frozen_string_literal: true

class Region
  class Show < BaseShowService

    def call
      RegionSerializer.render_as_hash(resource, view: :list)
    end

  end
end

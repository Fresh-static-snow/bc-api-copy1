# frozen_string_literal: true

class Region
  class Edit < BaseEditService

    def call
      RegionSerializer.render_as_hash(resource, view: :list)
    end

  end
end

# frozen_string_literal: true

class Branding
  class Edit < BaseEditService

    def call
      BrandingSerializer.render_as_hash(resource, view: :list)
    end

  end
end

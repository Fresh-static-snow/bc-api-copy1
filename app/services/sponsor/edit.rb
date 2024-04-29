# frozen_string_literal: true

class Sponsor
  class Edit < BaseEditService

    def call
      SponsorSerializer.render_as_hash(resource, view: :list)
    end

  end
end

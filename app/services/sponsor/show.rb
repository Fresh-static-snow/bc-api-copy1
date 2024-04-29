# frozen_string_literal: true

class Sponsor
  class Show < BaseShowService

    def call
      SponsorSerializer.render_as_hash(resource, view: :list)
    end

  end
end

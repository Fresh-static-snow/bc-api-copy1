# frozen_string_literal: true

class Sponsor
  class List < BaseListService

    def call
      SponsorSerializer.render_as_hash(resource, view: scope)
    end

  end
end

# frozen_string_literal: true

class Corporate
  class Show < BaseShowService

    def call
      CorporateSerializer.render_as_hash(resource, view: :show)
    end

  end
end

# frozen_string_literal: true

class CorporateCompany
  class Show < BaseShowService

    def call
      CorporateCompanySerializer.render_as_hash(resource, view: :list)
    end

  end
end

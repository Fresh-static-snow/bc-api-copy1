# frozen_string_literal: true

class CorporateCompany
  class List < BaseListService

    def call
      CorporateCompanySerializer.render_as_hash(resource, view: :list)
    end

  end
end

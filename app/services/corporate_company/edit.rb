# frozen_string_literal: true

class CorporateCompany
  class Edit < BaseEditService

    def call
      CorporateCompanySerializer.render_as_hash(resource, view: :list)
    end

  end
end

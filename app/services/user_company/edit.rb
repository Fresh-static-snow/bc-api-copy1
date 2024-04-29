# frozen_string_literal: true

class UserCompany
  class Edit < BaseEditService

    def call
      UserCompanySerializer.render_as_hash(resource, view: :edit)
    end

  end
end

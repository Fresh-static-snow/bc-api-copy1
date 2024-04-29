# frozen_string_literal: true

class UserCompany
  class List < BaseListService

    def call
      UserCompanySerializer.render_as_hash(resource, view: :list)
    end

  end
end

# frozen_string_literal: true

class Corporate
  class Edit < BaseEditService

    def call
      CorporateSerializer.render_as_hash(resource, view: :show)
    end

  end
end

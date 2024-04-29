# frozen_string_literal: true

class CorporateCompany
  class Update < BaseUpdateService

    def update_resource
      if params[:cover].blank?
        resource&.cover&.purge
        resource.update(params.except(:cover))
      else
        resource.update(params)
      end
    end

  end
end

# frozen_string_literal: true

class Branding
  class Update < BaseUpdateService

    def update_resource
      if params[:favicon].blank?
        resource.update(params.except(:favicon))
      else
        resource.update(params)
      end
    end

  end
end

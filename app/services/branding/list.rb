# frozen_string_literal: true

class Branding
  class List < BaseListService

    def call
      BrandingSerializer.render_as_hash(resource.order(:id), view: scope)
    end

    def scope
      params[:scope] == 'only_deleted' ? :only_deleted : :list
    end

  end
end

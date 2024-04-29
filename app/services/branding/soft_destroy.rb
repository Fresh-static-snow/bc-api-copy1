# frozen_string_literal: true

class Branding
  class SoftDestroy < BaseSoftDestroyService

    def call
      with_transaction do
        cache_logo if resource.logo.attached?
        cache_favicon if resource.favicon.attached?
        resource.destroy
      end

      collect_errors(resource)

      resource
    end

    private

    def cache_logo
      ArchivedImageResource.create!(
        item_type: resource.class.name,
        item_id: resource.id,
        item_column: :logo,
        resource: resource.logo.blob
      )
    end

    def cache_favicon
      ArchivedImageResource.create!(
        item_type: resource.class.name,
        item_id: resource.id,
        item_column: :favicon,
        resource: resource.favicon.blob
      )
    end

  end
end

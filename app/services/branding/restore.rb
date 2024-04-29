# frozen_string_literal: true

class Branding
  class Restore < BaseRestoreService

    def call
      with_transaction do
        resource.recover
        recover_logo if archived_logo
        recover_favicon if archived_favicon
      end

      collect_errors(resource)

      resource
    end

    private

    def archived_logo
      @archived_logo = ArchivedImageResource.where(
        item_type: resource.class.name,
        item_id: resource.id,
        item_column: :logo
      ).last
    end

    def archived_favicon
      @archived_favicon = ArchivedImageResource.where(
        item_type: resource.class.name,
        item_id: resource.id,
        item_column: :favicon
      ).last
    end

    def recover_logo
      resource.reload.logo.attach(archived_logo.resource.blob)

      archived_logo.destroy
    end

    def recover_favicon
      resource.reload.favicon.attach(archived_favicon.resource.blob)

      archived_favicon.destroy
    end

  end
end

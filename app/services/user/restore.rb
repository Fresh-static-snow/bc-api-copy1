# frozen_string_literal: true

class User
  class Restore < BaseUpdateService

    def call
      with_transaction do
        resource.update(hide_history: false)
        resource.recover
        attach_deleted_avatar if deleted_avatar
      end

      User::AddGoogleCalendarEvents.perform_later(resource)

      collect_errors(resource)

      resource
    end

    private

    def deleted_avatar
      @deleted_avatar ||= ArchivedImageResource.where(
        item_type: resource.class.name,
        item_id: resource.id,
        item_column: :avatar
      ).last
    end

    def attach_deleted_avatar
      resource.reload.avatar.attach(deleted_avatar.resource.blob)
      deleted_avatar.destroy
    end

  end
end

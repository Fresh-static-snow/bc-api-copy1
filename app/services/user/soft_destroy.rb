# frozen_string_literal: true

class User
  class SoftDestroy < Base

    include SendNotify

    attr_reader :resource, :params, :current_user

    def self.call(resource, params, current_user)
      new(resource, params, current_user).call
    end

    def initialize(resource, params, current_user)
      @resource = resource
      @params = params
      @current_user = current_user

      super()
    end

    def call # rubocop:disable Metrics/AbcSize
      with_transaction do
        update_resource
        cache_avatar_id if resource.avatar.attached?
        resource.destroy
      end

      User::DestroyGoogleCalendarEvents.perform_later(resource)

      collect_errors(resource)

      send_admin_notify(resource, :destroy, false)

      resource
    end

    private

    def update_resource
      resource.update(params)
    end

    def cache_avatar_id
      ArchivedImageResource.create!(
        item_type: resource.class.name,
        item_id: resource.id,
        item_column: :avatar,
        resource: resource.avatar.blob
      )
    end

  end
end

# frozen_string_literal: true

class Tournament
  class SoftDestroy < Base

    include ArchivedCover
    include SendNotify

    attr_accessor :resource, :current_user

    def self.call(resource, current_user)
      new(resource, current_user).call
    end

    def initialize(resource, current_user)
      @resource = resource
      @current_user = current_user

      super()
    end

    def call # rubocop:disable Metrics/AbcSize
      Tournament::RunBeforeDestroyJob.perform_now(resource)

      current_user_ids = []

      if resource.visible
        current_user_ids << resource.owner_id if resource.owner_id.present?

        resource.tournament_media_representatives.map do |m|
          current_user_ids << m.user_id
        end

        resource.tournament_main_participants.map do |m|
          current_user_ids << m.user_id
        end

        resource.matches.map do |m|
          next unless m.visible

          m.match_casts.map do |cast|
            cast.match_analytics.map do |a|
              current_user_ids << a.user_id
            end

            cast.match_commentators.map do |a|
              current_user_ids << a.user_id
            end

            cast.match_staff_members.map do |a|
              current_user_ids << a.user_id
            end
          end
        end

        current_user_ids = current_user_ids.uniq
      end

      with_transaction do
        cache_cover(resource) if resource.cover.attached?
        resource.destroy
      end

      collect_errors(resource)

      unless resource.errors.any?
        send_notify(resource, current_user_ids, :destroy, :deleted)
        send_admin_notify(resource, :destroy, true)
      end

      resource
    end

  end
end

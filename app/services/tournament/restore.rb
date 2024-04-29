# frozen_string_literal: true

class Tournament
  class Restore < Base

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
      with_transaction do
        recover_discipline

        resource.recover
        recover_cover(resource) if archived_cover(resource)
      end

      collect_errors(resource)

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

      unless resource.errors.any?
        send_notify(resource, current_user_ids, :restore, :added)
        send_admin_notify(resource, :restore, true)

        Tournament::RunAfterUpdateJob.perform_later(resource)
      end

      resource
    end

    private

    def recover_discipline
      discipline = GameDiscipline.only_deleted.find_by(id: resource.game_discipline_id)

      if discipline&.deleted?
        discipline.recover(recursive: false)
        recover_cover(discipline) if archived_cover(discipline)
      end
    end

  end
end

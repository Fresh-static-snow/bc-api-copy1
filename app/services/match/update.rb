# frozen_string_literal: true

class Match
  class Update < Base

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
      old_user_ids = Match::Cast.call(resource)

      with_transaction do
        update_resource
        destroy_deleted_casts
      end

      collect_errors(resource)

      unless resource.errors.any?
        current_user_ids = Match::Cast.call(resource)
        added_user_ids = Match::AddedCast.call(resource)
        deleted_user_ids = []
        tournament = resource.tournament

        deleted_user_ids = old_user_ids - current_user_ids if resource.visible && tournament.visible
        stay_users_ids = (old_user_ids - deleted_user_ids).uniq

        if resource.saved_changes[:visible].present?
          if resource.saved_changes[:visible]&.first
            added_user_ids = []
            deleted_user_ids = old_user_ids - added_user_ids
          else
            added_user_ids = current_user_ids - deleted_user_ids.uniq
            deleted_user_ids = []
          end
        end

        send_notify(resource, added_user_ids, :update, :added)
        send_notify(resource, deleted_user_ids, :update, :deleted)
        send_notify(resource, stay_users_ids, :update, nil)
        send_admin_notify(resource, :update, true)

        users = Match::AddedCast.new(resource).changed_records.map(&:user) +
                TournamentContext::MainParticipants.where(tournament_id: tournament.id).map(&:user)

        BotsNotifyJob.perform_later(users, resource, match_message_text(:update), :update)

        Match::RunAfterUpdateJob.perform_later(resource)
      end

      resource
    end

    private

    def update_resource
      resource.update(params)
    end

    def destroy_deleted_casts # rubocop:disable Metrics/AbcSize
      resource.match_casts.only_deleted.find_each(&:destroy_fully!)

      resource.match_casts.each do |cast|
        cast.match_analytics.only_deleted.find_each(&:destroy_fully!)
        cast.match_commentators.only_deleted.find_each(&:destroy_fully!)
        cast.match_staff_members.only_deleted.find_each(&:destroy_fully!)
        cast.match_backup_commentators.only_deleted.find_each(&:destroy_fully!)
        cast.match_host_analytic&.destroy_fully! unless cast.match_host_analytic&.user_id
      end
    end

  end
end

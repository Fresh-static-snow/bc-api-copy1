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

      unless resource.errors.any?
        send_notify(resource, added_user_ids, :update, :added)
        send_notify(resource, deleted_user_ids, :update, :deleted)
        send_notify(resource, stay_users_ids, :update, nil)
        send_admin_notify(resource, :update, true)

        Match::AddedCast.new(resource).changed_records.uniq(&:user_id).each do |talent|
          BotsNotification::MatchNotifiable.new(resource, talent, :update).perform if notifiable_rules(talent.user)
        end

        TournamentContext::MainParticipants.where(tournament_id: tournament.id).find_each do |mp|
          BotsNotification::MatchNotifiable.new(resource, mp, :update).perform if notifiable_rules(mp.user)
        end

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
        cast.match_backup_commentator&.destroy_fully! unless cast.match_backup_commentator.user_id
        cast.match_host_analytic&.destroy_fully! unless cast.match_backup_commentator.user_id
      end
    end

    def notifiable_rules(user)
      resource.reload.visible && resource.tournament.reload.visible ||
        User.with_permission(:create_entity).exists?(user.id)
    end

  end
end

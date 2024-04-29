# frozen_string_literal: true

class Tournament
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
      old_user_ids = Tournament::Participants.call(resource)

      with_transaction do
        update_resource

        destroy_deleted_participants
      end

      collect_errors(resource)

      added_user_ids = Tournament::AddedParticipants.call(resource)
      current_user_ids = Tournament::Participants.call(resource)

      deleted_user_ids = []
      deleted_user_ids = old_user_ids - current_user_ids if resource.visible == true

      if resource.saved_changes[:visible].present?
        matches_user_ids = resource.matches.select(&:visible).flat_map { |m| Match::Cast.call(m) }.uniq

        if resource.saved_changes[:visible]&.first == true
          added_user_ids = []
          deleted_user_ids = old_user_ids - added_user_ids + matches_user_ids
        else
          added_user_ids = current_user_ids - deleted_user_ids.uniq + matches_user_ids
          deleted_user_ids = []
        end
      end

      unless resource.errors.any?
        send_notify(resource, added_user_ids.uniq, :update, :added)
        send_notify(resource, deleted_user_ids.uniq, :update, :deleted)
        send_admin_notify(resource, :update, true)

        User.managment_staff.find_each do |user|
          BotsNotification::TournamentNotifiable.new(resource, user, :update).perform
        end

        Tournament::RunAfterUpdateJob.perform_later(resource)
      end

      resource
    end

    private

    def update_resource
      if params[:cover] == ""
        resource&.cover&.purge
        resource.update(params.except(:cover))
      else
        resource.update(params)
      end
    end

    def destroy_deleted_participants
      TournamentContext::MediaRepresentatives.only_deleted.where(tournament_id: resource.id).find_each(&:destroy_fully!)
      TournamentContext::MainParticipants.only_deleted.where(tournament_id: resource.id).find_each(&:destroy_fully!)
    end

  end
end

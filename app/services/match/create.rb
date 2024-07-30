# frozen_string_literal: true

class Match
  class Create < Base

    include SendNotify

    attr_reader :resource, :params, :current_user

    def self.call(params, current_user)
      new(params, current_user).call
    end

    def initialize(params, current_user)
      @params = params
      @current_user = current_user

      super()
    end

    def call # rubocop:disable Metrics/AbcSize
      with_transaction do
        create_resource
      end

      collect_errors(resource)

      unless resource.errors.any?
        Match::RunAfterCreateJob.perform_later(resource)

        added_user_ids = Match::AddedCast.call(resource)
        send_notify(resource, added_user_ids, :create, :added)
        send_admin_notify(resource, :create, true)

        users = Match::AddedCast.new(resource).changed_records.map(&:user) +
                TournamentContext::MainParticipants.where(tournament_id: resource.tournament.id).map(&:user)

        BotsNotifyJob.perform_later(users, resource, match_message_text(:create), :create)
      end

      resource
    end

    private

    def create_resource
      @resource = Match.create(params.merge(type: 'Match'))
    end

    def notifiable_rules(user)
      resource.reload.visible && resource.tournament.reload.visible ||
        User.with_permission(:create_entity).exists?(user.id)
    end

  end
end

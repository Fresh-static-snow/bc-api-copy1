# frozen_string_literal: true

class Corporate
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
      old_user_ids = Corporate::Participants.call(resource)

      with_transaction do
        update_resource

        destroy_deleted_participants
      end

      collect_errors(resource)

      deleted_user_ids = []
      current_user_ids = Corporate::Participants.call(resource)
      added_user_ids = Corporate::AddedParticipants.call(resource)
      deleted_user_ids = old_user_ids - current_user_ids if resource.visible == true

      if resource.saved_changes[:visible].present?
        if resource.saved_changes[:visible]&.first == true
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
        send_admin_notify(resource, :update, true)
      end

      resource
    end

    def update_resource # rubocop:disable Metrics/AbcSize
      params[:participant_ids] = params[:participant_ids].uniq if params[:participant_ids].present?

      if params[:cover] == ""
        resource&.cover&.purge
        resource.update(params.except(:cover))
      else
        resource.update(params)
      end
    end

    def destroy_deleted_participants
      CorporateParticipants.only_deleted.where(corporate_id: resource.id).find_each(&:destroy_fully!)
      CorporateMainParticipants.only_deleted.where(corporate_id: resource.id).find_each(&:destroy_fully!)
    end

  end
end

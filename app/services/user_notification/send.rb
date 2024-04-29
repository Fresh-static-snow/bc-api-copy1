# frozen_string_literal: true

class UserNotification
  class Send

    attr_reader :resource, :author, :user_id, :entity_action, :personal, :user_action

    def self.call(resource, author, user_id, entity_action, personal, user_action)
      new(resource, author, user_id, entity_action, personal, user_action).call
    end

    def initialize(resource, author, user_id, entity_action, personal, user_action)
      @resource = resource
      @author = author
      @user_id = user_id
      @entity_action = entity_action
      @personal = personal
      @user_action = user_action
    end

    def call
      send_notify
    end

    private

    def send_notify
      entity_type = resource.class.name
      entity_id = resource.id

      message = build_notification_message(entity_action, user_action, entity_type, entity_id)

      user_notification_params = {
        author_id: author.id,
        entity_type: entity_type,
        entity_action: entity_action,
        entity_id: entity_id,
        title: message,
        description: '',
        user_id: user_id,
        personal: personal
      }

      NotifyJob.perform_later(user_notification_params)
    end

    def build_notification_message(entity_action, user_action, entity_type, entity_id)
      if user_action.present?
        "You have been #{user_action} by #{author.email} to the #{entity_type}: #{entity_id}"
      else
        "User #{author.email} made changes(#{entity_action}) to the #{entity_type}: #{entity_id}"
      end
    end

  end
end

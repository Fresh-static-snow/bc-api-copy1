# frozen_string_literal: true

module SendNotify

  extend ActiveSupport::Concern

  included do
    def send_notify(resource, added_users_id, entity_action, user_action)
      added_users_id.map do |u|
        UserNotification::Send.call(resource, current_user, u, entity_action, true, user_action)
      end
    end

    def send_admin_notify(resource, entity_action, personal)
      User.with_permission(:dashboard_all).pluck(:id).each do |u|
        UserNotification::Send.call(resource, current_user, u, entity_action, personal, nil)
      end
    end
  end

end

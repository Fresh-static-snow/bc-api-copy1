# frozen_string_literal: true

class NotifyJob < ApplicationJob

  queue_as :default

  def perform(notify)
    created_notify = UserNotification::Create.call(notify)

    if created_notify.errors.empty?
      serialized_notify = UserNotificationSerializer.render_as_hash(created_notify)

      if notify[:personal] == true
        NotifyCalendarChannel.broadcast_to(created_notify.user, serialized_notify)
      else
        NotifyDashboardChannel.broadcast_to(created_notify.user, serialized_notify)
      end
    end
  end

end

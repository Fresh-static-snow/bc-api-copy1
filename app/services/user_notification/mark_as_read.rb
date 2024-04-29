# frozen_string_literal: true

class UserNotification
  class MarkAsRead < Base

    def self.call(user_id, notify_id)
      new(user_id, notify_id).call
    end

    def call
      with_transaction do
        update_notify
      end
    end

    private

    attr_reader :user_id, :notify_id

    def initialize(user_id, notify_id)
      @user_id = user_id
      @notify_id = notify_id

      super()
    end

    def update_notify
      user_notify = UserNotification.where(user_id: user_id)

      if notify_id == :all
        user_notify.update(seen: true)
      else
        user_notify.where(id: notify_id).update(seen: true)
      end
    end

  end
end

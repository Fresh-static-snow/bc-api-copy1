# frozen_string_literal: true

class User
  class NotificationsCount

    attr_reader :user, :scope

    def self.call(user, params)
      new(user, params).call
    end

    def initialize(user, params)
      @user = user
      @scope = params[:scope]
    end

    def call
      notifications = user.user_notifications.select('id').where(seen: false)
      notifications = notifications.management if scope == 'dashboard'
      notifications = notifications.calendar if scope == 'account'

      {
        count: notifications.count
      }
    end

  end
end

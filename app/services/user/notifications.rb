# frozen_string_literal: true

class User
  class Notifications

    attr_reader :user, :notifications, :scope, :page, :per_page, :start_id

    def self.call(user, params)
      new(user, params).call
    end

    def initialize(user, params)
      @user = user
      @page = params[:page] || 1
      @per_page = params[:per_page] || 10
      @scope = params[:scope]
      @start_id = params[:start_id]
    end

    def call # rubocop:disable Metrics/AbcSize
      notifications = user.user_notifications
      notifications = notifications.where('id < ?', start_id) if start_id.present?
      notifications = notifications.management if scope == 'dashboard'
      notifications = notifications.calendar if scope == 'account'
      notifications = notifications.sort_by_date.paginate(page: page.to_i, per_page: per_page.to_i)
      notifications = notifications.includes(
        user: { avatar_attachment: :blob },
        author: { avatar_attachment: :blob }
      )

      data = {
        notifications: UserNotificationSerializer.render_as_hash(notifications),
        total_pages: notifications.total_pages
      }

      data[:start_id] = notifications.first&.id if page.to_i == 1

      data
    end

  end
end

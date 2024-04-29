class AddCreatedAtToUserNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :user_notifications, :created_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
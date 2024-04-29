class AddFieldsToUserNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :user_notifications, :author_id, :integer
    add_column :user_notifications, :entity_type, :string
    add_column :user_notifications, :entity_id, :integer
    add_column :user_notifications, :entity_action, :string
    add_column :user_notifications, :personal, :boolean
  end
end

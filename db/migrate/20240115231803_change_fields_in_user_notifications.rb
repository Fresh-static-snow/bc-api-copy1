class ChangeFieldsInUserNotifications < ActiveRecord::Migration[6.0]
  def change
    UserNotification.with_deleted.where("entity_type IS NULL OR entity_id IS NULL").find_each(&:destroy_fully!)

    change_column :user_notifications, :entity_type, :string, null: false
    change_column :user_notifications, :entity_id, :integer, null: false
  end
end

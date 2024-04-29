class CreateUserNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :user_notifications do |t|
      t.string :title
      t.text :description
      t.boolean :seen, default: false

      t.integer :user_id

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

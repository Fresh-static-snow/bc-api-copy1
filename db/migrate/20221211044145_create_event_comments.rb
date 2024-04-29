class CreateEventComments < ActiveRecord::Migration[6.0]
  def change
    create_table :event_comments do |t|
      t.string :event_type
      t.text :message

      t.integer :user_id
      t.integer :event_id

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

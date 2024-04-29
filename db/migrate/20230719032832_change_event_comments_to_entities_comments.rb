# Update the existing migration file
class ChangeEventCommentsToEntitiesComments < ActiveRecord::Migration[6.0]
  def change
    drop_table :event_comments

    create_table :entity_comments do |t|
      t.string :entity_type
      t.text :message

      t.integer :user_id
      t.integer :entity_id

      t.datetime :created_at

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

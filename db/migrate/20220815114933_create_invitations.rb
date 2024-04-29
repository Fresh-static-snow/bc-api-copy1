class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.string :email, null: false

      t.integer :created_by_id, null: false
      t.integer :role_id, null: false

      t.timestamps

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

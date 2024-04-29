class CreateUserRolesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :user_roles do |t|
      t.references :user, foreign_key: true
      t.references :role, foreign_key: true

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end

    add_index :user_roles, [:user_id, :role_id], name: "index_user_roles_uniqueness", unique: true
  end
end

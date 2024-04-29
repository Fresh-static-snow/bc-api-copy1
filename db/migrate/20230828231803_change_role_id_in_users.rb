class ChangeRoleIdInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :role_id, :integer, null: true, default: nil
  end
end

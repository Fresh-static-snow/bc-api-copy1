class AddPermissionsInRoles< ActiveRecord::Migration[6.0]
  def change
    add_column :roles, :permissions, :jsonb, default: '{}', using: 'permissions::jsonb'
  end
end

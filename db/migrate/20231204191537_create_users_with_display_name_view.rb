class CreateUsersWithDisplayNameView < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :display_name, :string, null: true

    User.all.each do |user|
      user.update_display_name_column
    end
  end

  def down
    remove_column :users, :display_name
  end
end

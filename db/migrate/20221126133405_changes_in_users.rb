class ChangesInUsers < ActiveRecord::Migration[6.0]
  def up
    remove_index :users, name: 'index_users_on_discipline_id'
    remove_column :users, :discipline_id

    add_column :users, :user_discipline_id, :integer
    add_index :users, :user_discipline_id
  end

  def down
    remove_index :users, name: 'index_users_on_user_discipline_id'
    remove_column :users, :user_discipline_id

    add_column :users, :discipline_id, :integer
    add_index :users, :discipline_id
  end
end

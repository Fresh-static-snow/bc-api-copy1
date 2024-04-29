class RemoveUserDisciplineIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :user_discipline_id
  end
end

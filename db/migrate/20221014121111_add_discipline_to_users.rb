class AddDisciplineToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :discipline_id, :integer
    add_index :users, :discipline_id
  end
end

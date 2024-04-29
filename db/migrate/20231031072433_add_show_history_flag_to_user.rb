class AddShowHistoryFlagToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hide_history, :boolean, default: false
  end
end

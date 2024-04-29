class AddFieldToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :google_calendar, :boolean, null: false, default: false
  end
end

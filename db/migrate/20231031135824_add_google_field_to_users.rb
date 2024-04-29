class AddGoogleFieldToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :google_calendar_required, :boolean, null: false, default: false
    remove_column :users, :google_calendar
    add_column :users, :google_calendar_status, :boolean, null: false, default: false
  end
end

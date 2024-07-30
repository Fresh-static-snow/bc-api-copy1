class CreateAccountSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :account_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :current_user_filter_enabled, default: true
      t.integer :default_calendar_scope, default: 0

      t.timestamps
    end

    User.all.each do |user|
      user.create_account_setting
    end
  end
end

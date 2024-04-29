class AddDiscordUserId < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :discord_user_id, :bigint
  end
end

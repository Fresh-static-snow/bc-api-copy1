class AddTelegramIdColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :telegram_chat_id, :integer
  end
end

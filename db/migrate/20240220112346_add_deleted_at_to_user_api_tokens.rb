class AddDeletedAtToUserApiTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :user_api_tokens, :deleted_at, :datetime, null: true, default: nil
    add_index :user_api_tokens, :deleted_at
  end
end

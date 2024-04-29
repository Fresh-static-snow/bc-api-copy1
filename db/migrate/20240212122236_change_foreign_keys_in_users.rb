class ChangeForeignKeysInUsers < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key(:users, :user_companies)
    add_foreign_key :users, :user_companies, column: :company_id, null: true
  end
end

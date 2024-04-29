class CreateUserApiTokensTable < ActiveRecord::Migration[6.0]
  def change
    create_table :user_api_tokens do |t|
      t.references :user, foreign_key: true
      t.text :access_token
      t.string :refresh_token
      t.datetime :expires_at
      t.timestamps
    end
  end
end

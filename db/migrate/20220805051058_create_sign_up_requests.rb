class CreateSignUpRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :sign_up_requests do |t|
      t.integer :status, null: false, default: 0

      t.integer :user_id, null: false

      t.timestamps

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

class CreateCorporateMainParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :corporate_main_participants do |t|
      t.integer :corporate_id, null: false
      t.integer :user_id, null: false

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

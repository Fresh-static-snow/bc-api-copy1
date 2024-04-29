class CreateCorporateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :corporate_participants do |t|
      t.integer :corporate_id, null: false
      t.integer :user_id
      t.integer :user_discipline_id

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

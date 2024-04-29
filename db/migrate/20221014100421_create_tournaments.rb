class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :title, null: false
      t.boolean :visible, null: false, default: false
      t.date :start_at
      t.date :end_at

      t.integer :region_id
      t.integer :type_id
      t.integer :owner_id
      t.integer :game_discipline_id

      t.timestamps

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

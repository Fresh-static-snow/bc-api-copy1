class CreateCorporates < ActiveRecord::Migration[6.0]
  def change
    create_table :corporates do |t|
      t.string :name, null: false
      t.boolean :visible, null: false, default: false
      t.string :location
      t.datetime :start_at
      t.datetime :end_at
      t.text :description

      t.integer :game_discipline_id

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

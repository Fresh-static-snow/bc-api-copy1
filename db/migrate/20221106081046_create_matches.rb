class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :title, null: false
      t.boolean :visible, null: false, default: false
      t.datetime :start_at
      t.datetime :end_at
      t.integer :best_of

      t.integer :game_discipline_id
      t.integer :tournament_id
      t.integer :team_one_id
      t.integer :team_two_id

      t.timestamps

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

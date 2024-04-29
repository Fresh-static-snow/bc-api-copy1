class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :keyword

      t.integer :game_discipline_id

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

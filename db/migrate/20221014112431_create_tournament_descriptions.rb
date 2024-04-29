class CreateTournamentDescriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :tournament_descriptions do |t|
      t.integer :tournament_id, null: false
      t.string :title, null: false
      t.text :description, null: false

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

class CreateTournamentTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :tournament_types do |t|
      t.string :name, null: false

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

class CreateTournamentSponsors < ActiveRecord::Migration[6.0]
  def change
    create_table :tournament_sponsors do |t|
      t.integer :tournament_id
      t.integer :sponsor_id

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

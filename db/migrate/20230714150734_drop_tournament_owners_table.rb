class DropTournamentOwnersTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :tournament_owners
  end
end

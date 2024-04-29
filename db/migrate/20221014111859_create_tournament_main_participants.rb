class CreateTournamentMainParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :tournament_main_participants do |t|
      t.integer :tournament_id, null: false
      t.integer :user_id, null: false

      t.index %i[tournament_id user_id], unique: true, name: 'index_tournament_main_participants_on_t_id_and_u_id'

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

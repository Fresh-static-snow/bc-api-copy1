class CreateTournamentMedia < ActiveRecord::Migration[6.0]
  def change
    create_table :tournament_media do |t|
      t.integer :tournament_id, null: false
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

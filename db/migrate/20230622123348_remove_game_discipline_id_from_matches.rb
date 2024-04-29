class RemoveGameDisciplineIdFromMatches < ActiveRecord::Migration[6.0]
  def change
    remove_column :matches, :game_discipline_id
  end
end

class AddOrderToGameDisciplines < ActiveRecord::Migration[6.0]
  def change
    add_column :game_disciplines, :order, :integer, default: 0
  end
end

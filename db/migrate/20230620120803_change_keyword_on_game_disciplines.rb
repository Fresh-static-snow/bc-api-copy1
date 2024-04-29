class ChangeKeywordOnGameDisciplines < ActiveRecord::Migration[6.0]
  def change
    remove_column :game_disciplines, :keyword
    add_column :game_disciplines, :keyword, :string, null: true
  end
end

class ChangeGmaDisciplineIdOnCorporates < ActiveRecord::Migration[6.0]
  def change
    remove_column :corporates, :game_discipline_id
    add_column :corporates, :company_id, :integer
  end
end

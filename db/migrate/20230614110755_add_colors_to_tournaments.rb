class AddColorsToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :ui_template, :json
  end
end

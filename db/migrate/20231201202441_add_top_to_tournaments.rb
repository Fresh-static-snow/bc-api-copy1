class AddTopToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :top, :integer, null: false, default: 3
  end
end

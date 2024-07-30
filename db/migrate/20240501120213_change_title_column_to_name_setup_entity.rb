class ChangeTitleColumnToNameSetupEntity < ActiveRecord::Migration[6.0]
  def change
    rename_column :cast_setups, :title, :name 
  end
end

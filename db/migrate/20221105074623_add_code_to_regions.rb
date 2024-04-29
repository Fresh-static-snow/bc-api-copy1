class AddCodeToRegions < ActiveRecord::Migration[6.0]
  def change
    add_column :regions, :code, :string
  end
end

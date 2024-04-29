class CreateRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :regions do |t|
      t.string :name, null: false

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

class CreateSetups < ActiveRecord::Migration[6.0]
  def change
    create_table :cast_setups do |t|
      t.string :title

      t.datetime :deleted_at
      t.index :deleted_at

      t.timestamps
    end
  end
end

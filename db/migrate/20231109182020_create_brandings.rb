class CreateBrandings < ActiveRecord::Migration[6.0]
  def change
    create_table :brandings do |t|
      t.string :name
      t.boolean :visible, null: false, default: false

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

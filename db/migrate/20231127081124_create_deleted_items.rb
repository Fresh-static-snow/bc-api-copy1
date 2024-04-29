class CreateDeletedItems < ActiveRecord::Migration[6.0]
  def change
    create_table :deleted_items do |t|
      t.integer :cast_item_id
      t.string :cast_item_type
      t.integer :match_cast_ids, array: true, default: []

      t.timestamps
    end
  end
end

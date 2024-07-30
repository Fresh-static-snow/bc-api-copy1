class CreateDescriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :descriptions do |t|
      t.string :title
      t.text :description
      t.bigint :segment_id

      t.timestamps
    end
  end
end

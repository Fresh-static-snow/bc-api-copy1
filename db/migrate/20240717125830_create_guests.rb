class CreateGuests < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.string :name
      t.string :username
      t.string :social
      t.bigint :segment_id

      t.timestamps
    end
  end
end

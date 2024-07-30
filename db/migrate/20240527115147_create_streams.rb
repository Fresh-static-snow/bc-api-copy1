class CreateStreams < ActiveRecord::Migration[6.0]
  def change
    create_table :cast_streams do |t|
      t.string :name

      t.datetime :deleted_at
      t.index :deleted_at

      t.timestamps
    end
  end
end

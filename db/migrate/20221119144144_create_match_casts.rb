class CreateMatchCasts < ActiveRecord::Migration[6.0]
  def change
    create_table :match_casts do |t|
      t.integer :match_id
      t.integer :cast_language_id
      t.integer :cast_studio_id
      t.integer :cast_studio_analytics_id
      t.integer :cast_channel_id

      t.index :match_id

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

class CreateMatchAnalytics < ActiveRecord::Migration[6.0]
  def change
    create_table :match_analytics do |t|
      t.integer :match_cast_id
      t.integer :user_id

      t.index %i[match_cast_id user_id], unique: true

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

class CreateHostAnalytics < ActiveRecord::Migration[6.0]
  def change
    create_table :match_host_analytics do |t|
      t.references :user
      t.references :match_cast

      t.bigint :tournament_id

      t.datetime :deleted_at
      t.index :deleted_at

      t.timestamps
    end
  end
end

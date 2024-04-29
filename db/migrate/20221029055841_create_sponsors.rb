class CreateSponsors < ActiveRecord::Migration[6.0]
  def change
    create_table :sponsors do |t|
      t.string :name

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

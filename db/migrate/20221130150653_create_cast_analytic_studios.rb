class CreateCastAnalyticStudios < ActiveRecord::Migration[6.0]
  def change
    create_table :cast_analytic_studios do |t|
      t.string :name
      t.string :keyword

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

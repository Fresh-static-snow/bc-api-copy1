class CreateCastLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :cast_languages do |t|
      t.string :name
      t.string :keyword

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

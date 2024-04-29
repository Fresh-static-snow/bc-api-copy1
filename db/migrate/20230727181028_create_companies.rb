class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :title, null: false
      t.string :keyword, null: false

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

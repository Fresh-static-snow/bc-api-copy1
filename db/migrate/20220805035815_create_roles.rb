class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :title, null: false

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

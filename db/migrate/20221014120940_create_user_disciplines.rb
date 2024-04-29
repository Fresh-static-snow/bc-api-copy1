class CreateUserDisciplines < ActiveRecord::Migration[6.0]
  def change
    create_table :user_disciplines do |t|
      t.string :title

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

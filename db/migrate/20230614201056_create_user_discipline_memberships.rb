class CreateUserDisciplineMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :user_discipline_memberships do |t|
      t.references :user, foreign_key: true
      t.references :user_discipline, foreign_key: true

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end

    add_index :user_discipline_memberships, [:user_id, :user_discipline_id], name: "index_user_discipline_memberships_uniqueness", unique: true
  end
end

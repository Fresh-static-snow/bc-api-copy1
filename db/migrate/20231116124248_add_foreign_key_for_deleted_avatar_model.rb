class AddForeignKeyForDeletedAvatarModel < ActiveRecord::Migration[6.0]
  def change
    add_column :deleted_user_avatars, :user_id, :integer
  end
end

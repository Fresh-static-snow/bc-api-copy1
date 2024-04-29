class CreateDeletedUserAvatars < ActiveRecord::Migration[6.0]
  def change
    create_table :deleted_user_avatars do |t|

      t.timestamps
    end
  end
end

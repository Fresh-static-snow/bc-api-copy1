class ReworkDeletedUserAvatar < ActiveRecord::Migration[6.0]
  def up
    create_table :archived_image_resources do |t|
      t.string :item_type
      t.integer :item_id
      t.string :item_column

      t.timestamps
    end

    DeletedUserAvatar.find_each do |record|
      ArchivedImageResource.create!(
        item_type: 'User',
        item_id: record.user_id,
        item_column: :avatar,
        resource: record.avatar.blob
      )
    end

    drop_table :deleted_user_avatars
  end

  def down
    create_table :deleted_user_avatars do |t|
      t.integer :user_id

      t.timestamps
    end

    ArchivedImageResource.find_each do |record|
      DeletedUserAvatar.create!(user_id: record.user_id, avatar: record.resource.blob)
    end

    drop_table :archived_image_resources
  end

end

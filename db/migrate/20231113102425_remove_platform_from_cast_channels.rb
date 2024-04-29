class RemovePlatformFromCastChannels < ActiveRecord::Migration[6.0]
  def change
    remove_column :cast_channels, :platform

    rename_column :cast_channels, :username, :name
  end
end

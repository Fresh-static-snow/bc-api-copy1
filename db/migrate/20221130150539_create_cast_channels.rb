class CreateCastChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :cast_channels do |t|
      t.string :platform, default: 'Twitch'
      t.string :username

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end

class CreateMatchCastsChannels < ActiveRecord::Migration[6.0]
  def up
    create_table :match_casts_channels do |t|
      t.bigint :match_cast_id, foreign_key: true
      t.bigint :channel_id, foreign_key: true

      # soft delete
      t.datetime :deleted_at
      t.index :deleted_at

      t.timestamps
    end

    MatchCast.all.each do |match_cast|
      MatchCastsChannel.create!(match_cast_id: match_cast.id, channel_id: match_cast.cast_channel_id)
    end

    remove_column :match_casts, :cast_channel_id, foreign_key: true
  end

  def down
    add_column :match_casts, :cast_channel_id, :bigint, foreign_key: true

    MatchCast.all.each do |match_cast|
      match_cast.cast_channel_id = match_cast.match_casts_channels&.first&.channel_id
      match_cast.save
    end

    drop_table :match_casts_channels
  end
end

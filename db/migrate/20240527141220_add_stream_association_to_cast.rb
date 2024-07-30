class AddStreamAssociationToCast < ActiveRecord::Migration[6.0]
  def change
    add_column :match_casts, :cast_stream_id, :integer
  end
end

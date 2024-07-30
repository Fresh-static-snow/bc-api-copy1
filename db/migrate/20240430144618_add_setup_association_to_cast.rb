class AddSetupAssociationToCast < ActiveRecord::Migration[6.0]
  def change
    add_column :match_casts, :cast_setup_id, :integer
  end
end

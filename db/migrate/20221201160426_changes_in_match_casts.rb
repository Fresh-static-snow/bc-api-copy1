class ChangesInMatchCasts < ActiveRecord::Migration[6.0]
  def change
    remove_column :match_casts, :cast_studio_analytics_id

    add_column :match_casts, :cast_analytic_studio_id, :integer
  end
end

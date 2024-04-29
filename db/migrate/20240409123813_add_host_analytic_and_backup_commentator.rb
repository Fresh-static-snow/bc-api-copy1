class AddHostAnalyticAndBackupCommentator < ActiveRecord::Migration[6.0]
  def change
    add_column :match_casts, :host_analytic_id, :int
    add_column :match_casts, :backup_commentator_id, :int
  end
end

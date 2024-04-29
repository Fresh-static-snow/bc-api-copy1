class ChangeJsonFieldsDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column :roles, :permissions, :jsonb, default: {}, using: 'permissions::jsonb'
    change_column :tournaments, :ui_template, :jsonb, default: {}, using: 'ui_template::jsonb'
    change_column :corporates, :ui_template, :jsonb, default: {}, using: 'ui_template::jsonb'
    change_column :matches, :google_event_ids, :jsonb, default: {}, using: 'google_event_ids::jsonb'
  end
end

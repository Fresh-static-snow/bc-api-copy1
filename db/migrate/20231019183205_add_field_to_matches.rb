class AddFieldToMatches < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :google_event_ids, :jsonb, using: 'google_event_ids::jsonb'
  end
end

# Update the existing migration file
class ChangeUiTemplateToJsonbInTournaments < ActiveRecord::Migration[6.0]
  def change
    change_column :tournaments, :ui_template, :jsonb, default: '{}', using: 'ui_template::jsonb'
  end
end

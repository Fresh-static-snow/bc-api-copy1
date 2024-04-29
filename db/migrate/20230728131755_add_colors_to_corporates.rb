class AddColorsToCorporates < ActiveRecord::Migration[6.0]
  def change
    add_column :corporates, :ui_template, :jsonb, default: '{}', using: 'ui_template::jsonb'
  end
end

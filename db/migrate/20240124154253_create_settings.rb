class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.integer :match_duration, default: 60

      t.timestamps
    end

    Setting.create!
  end
end

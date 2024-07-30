class MoveAllMatchesToMatchType < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL.squish
      UPDATE matches
      SET type = 'Match'
      WHERE type IS NULL;
    SQL
  end
end

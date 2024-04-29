class AddTournamentIdColumnToTalent < ActiveRecord::Migration[6.0]
  def up
    add_column :match_analytics, :tournament_id, :integer
    add_column :match_commentators, :tournament_id, :integer
    add_column :match_staff_members, :tournament_id, :integer

    execute <<-SQL
      UPDATE match_staff_members
      SET tournament_id = (
          SELECT matches.tournament_id
          FROM matches
          JOIN match_casts ON matches.id = match_casts.match_id
          WHERE match_casts.id = match_staff_members.match_cast_id
      );
    SQL

    execute <<-SQL
      UPDATE match_commentators
      SET tournament_id = (
          SELECT matches.tournament_id
          FROM matches
          JOIN match_casts ON matches.id = match_casts.match_id
          WHERE match_casts.id = match_commentators.match_cast_id
      );
    SQL

    execute <<-SQL
      UPDATE match_analytics
      SET tournament_id = (
          SELECT matches.tournament_id
          FROM matches
          JOIN match_casts ON matches.id = match_casts.match_id
          WHERE match_casts.id = match_analytics.match_cast_id
      );
    SQL
  end

  def down
    remove_column :match_analytics, :tournament_id
    remove_column :match_commentators, :tournament_id
    remove_column :match_staff_members, :tournament_id
  end
end

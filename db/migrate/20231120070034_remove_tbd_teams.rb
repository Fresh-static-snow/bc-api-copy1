class RemoveTbdTeams < ActiveRecord::Migration[6.0]
  def change
    tbd_teams = Team.filter_by_term('tbd').pluck(:id)

    Match.where(team_one_id: tbd_teams).each do |match|
      match.update_column(:team_one_id, nil)
    end
    Match.where(team_two_id: tbd_teams).each do |match|
      match.update_column(:team_two_id, nil)
    end

    Team.filter_by_term('tbd').each do |t|
      t.destroy
    end
  end
end

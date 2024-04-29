# frozen_string_literal: true

# == Schema Information
#
# Table name: teams
#
#  id                 :bigint           not null, primary key
#  deleted_at         :datetime
#  keyword            :string
#  name               :string
#  game_discipline_id :integer
#
# Indexes
#
#  index_teams_on_deleted_at  (deleted_at)
#
class TeamSerializer < Blueprinter::Base

  identifier :id

  view :list do
    fields :name
    association :discipline, blueprint: GameDisciplineSerializer, view: :list
  end

  view :with_history do
    include_view :list

    field :events_count do |record|
      match_ids = Match.where("team_one_id = :id OR team_two_id = :id", id: record.id)
      tournaments = Tournament.where(id: match_ids.ids)

      tournaments.size
    end

    field :related_events do |record|
      match_ids = Match.where("team_one_id = :id OR team_two_id = :id", id: record.id)
      tournaments = Tournament.where(id: match_ids.ids)

      tournaments.map do |tournament|
        {
          id: tournament.id,
          title: tournament.title
        }
      end
    end
  end

end

# frozen_string_literal: true

# == Schema Information
#
# Table name: cast_analytic_studios
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  keyword    :string
#  name       :string
#
# Indexes
#
#  index_cast_analytic_studios_on_deleted_at  (deleted_at)
#
module CastContext
  class ApplicationSerializer < Blueprinter::Base

    identifier :id

    view :with_history do
      include_view :list

      field :events_count do |record|
        match_ids = if record.deleted?
                      MatchCast.where(id: DeletedItem.where(cast_item_type: record.class.name,
                                                            cast_item_id: record.id).last.match_cast_ids)
                               .map(&:match_id)
                    else
                      record.match_casts.map(&:match_id)
                    end
        tournament_ids = Match.where(id: match_ids).pluck(:tournament_id)
        tournaments = Tournament.where(id: tournament_ids)

        tournaments.size
      end

      field :related_events do |record|
        match_ids = if record.deleted?
                      MatchCast.where(id: DeletedItem.where(cast_item_type: record.class.name,
                                                            cast_item_id: record.id).last.match_cast_ids)
                               .map(&:match_id)
                    else
                      record.match_casts.map(&:match_id)
                    end
        tournament_ids = Match.where(id: match_ids).pluck(:tournament_id)
        tournaments = Tournament.where(id: tournament_ids)

        tournaments.map do |tournament|
          {
            id: tournament.id,
            title: tournament.title
          }
        end
      end
    end

  end
end

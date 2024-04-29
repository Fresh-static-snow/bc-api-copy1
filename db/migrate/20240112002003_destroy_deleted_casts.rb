class DestroyDeletedCasts < ActiveRecord::Migration[6.0]
  def change
    match_ids = Match.all.pluck(:id)
    match_cast_ids = MatchCast.only_deleted.where(match_id: match_ids).pluck(:id)

    MatchContext::Analytics.only_deleted.where(match_cast_id: match_cast_ids).each(&:destroy_fully!)
    MatchContext::Commentators.only_deleted.where(match_cast_id: match_cast_ids).each(&:destroy_fully!)
    MatchContext::StaffMembers.only_deleted.where(match_cast_id: match_cast_ids).each(&:destroy_fully!)

    MatchCast.only_deleted.where(match_id: match_ids).each(&:destroy_fully!)
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: match_analytics
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  match_cast_id :integer
#  tournament_id :integer
#  user_id       :integer
#
# Indexes
#
#  index_match_analytics_on_deleted_at                 (deleted_at)
#  index_match_analytics_on_match_cast_id_and_user_id  (match_cast_id,user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (match_cast_id => match_casts.id)
#  fk_rails_...  (tournament_id => tournaments.id)
#  fk_rails_...  (user_id => users.id)
#
module MatchContext
  class Analytics < ApplicationRecord

    self.table_name = :match_analytics

    acts_as_paranoid

    include AnalyticsModule::Associations
    include MatchContext::SetTournament

    def analytic?
      true
    end

  end
end

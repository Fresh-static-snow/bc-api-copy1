# frozen_string_literal: true

# == Schema Information
#
# Table name: match_host_analytics
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  match_cast_id :bigint
#  tournament_id :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_match_host_analytics_on_deleted_at     (deleted_at)
#  index_match_host_analytics_on_match_cast_id  (match_cast_id)
#  index_match_host_analytics_on_user_id        (user_id)
#
module MatchContext
  class HostAnalytic < ApplicationRecord

    self.table_name = :match_host_analytics

    acts_as_paranoid

    include HostAnalyticModule::Associations
    include MatchContext::SetTournament

    def analytic?
      true
    end

  end
end

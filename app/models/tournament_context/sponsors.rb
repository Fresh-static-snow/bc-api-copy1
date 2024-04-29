# frozen_string_literal: true

# == Schema Information
#
# Table name: tournament_sponsors
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  sponsor_id    :integer
#  tournament_id :integer
#
# Indexes
#
#  index_tournament_sponsors_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (sponsor_id => tournament_sponsors.id)
#  fk_rails_...  (tournament_id => tournaments.id)
#
module TournamentContext
  class Sponsors < ApplicationRecord

    self.table_name = :tournament_sponsors

    acts_as_paranoid

    include SponsorsModule::Associations

  end
end

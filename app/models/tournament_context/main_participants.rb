# frozen_string_literal: true

# == Schema Information
#
# Table name: tournament_main_participants
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  tournament_id :integer          not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_tournament_main_participants_on_deleted_at     (deleted_at)
#  index_tournament_main_participants_on_t_id_and_u_id  (tournament_id,user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (tournament_id => tournaments.id)
#  fk_rails_...  (user_id => users.id)
#
module TournamentContext
  class MainParticipants < ApplicationRecord

    self.table_name = :tournament_main_participants

    acts_as_paranoid

    include MainParticipantsModule::Associations

    def main_participant?
      true
    end

  end
end

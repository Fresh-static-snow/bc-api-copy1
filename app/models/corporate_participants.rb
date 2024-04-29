# frozen_string_literal: true

# == Schema Information
#
# Table name: corporate_participants
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  corporate_id :integer          not null
#  user_id      :integer
#
# Indexes
#
#  index_corporate_participants_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (corporate_id => corporates.id)
#  fk_rails_...  (user_id => users.id)
#
class CorporateParticipants < ApplicationRecord

  self.table_name = :corporate_participants

  acts_as_paranoid

  include CorporateParticipantsModule::Associations

end

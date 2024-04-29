# frozen_string_literal: true

# == Schema Information
#
# Table name: match_backup_commentators
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
#  index_match_backup_commentators_on_deleted_at     (deleted_at)
#  index_match_backup_commentators_on_match_cast_id  (match_cast_id)
#  index_match_backup_commentators_on_user_id        (user_id)
#
module MatchContext
  class BackupCommentator < ApplicationRecord

    self.table_name = :match_backup_commentators

    acts_as_paranoid

    include BackupCommentatorModule::Associations
    include MatchContext::SetTournament

    def commentator?
      true
    end

  end
end

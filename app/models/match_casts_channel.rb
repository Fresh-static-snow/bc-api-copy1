# frozen_string_literal: true

# == Schema Information
#
# Table name: match_casts_channels
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  channel_id    :bigint
#  match_cast_id :bigint
#
# Indexes
#
#  index_match_casts_channels_on_deleted_at  (deleted_at)
#
class MatchCastsChannel < ApplicationRecord

  self.table_name = :match_casts_channels

  include MatchCastsChannelModule::Associations

end

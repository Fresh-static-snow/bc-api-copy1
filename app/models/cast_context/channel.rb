# frozen_string_literal: true

# == Schema Information
#
# Table name: cast_channels
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#
# Indexes
#
#  index_cast_channels_on_deleted_at  (deleted_at)
#
module CastContext
  class Channel < ApplicationRecord

    self.table_name = :cast_channels

    acts_as_paranoid

    include Filterable
    include ChannelModule::Associations
    include ChannelModule::Scopes
    include ChannelModule::Validations

    def related_tournaments
      Tournament.joins(matches: { match_casts: :match_casts_channels })
                .where(match_casts_channels: { channel_id: id })
                .distinct
    end

  end
end

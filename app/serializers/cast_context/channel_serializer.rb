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
  class ChannelSerializer < ApplicationSerializer

    view :list do
      fields :name
    end

    view :with_history do
      include_view :list

      field :events_count do |channel|
        channel.related_tournaments.size
      end

      field :related_events do |channel| # rubocop:disable Style/SymbolProc
        channel.related_tournaments
      end
    end

  end
end

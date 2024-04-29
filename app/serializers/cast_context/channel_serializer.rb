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

  end
end

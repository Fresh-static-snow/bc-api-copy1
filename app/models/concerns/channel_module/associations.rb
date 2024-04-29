# frozen_string_literal: true

module ChannelModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_many :match_cast_channels, dependent: :destroy
      has_many :match_casts, through: :match_cast_channels, dependent: :destroy
    end

  end
end

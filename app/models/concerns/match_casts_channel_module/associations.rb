# frozen_string_literal: true

module MatchCastsChannelModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :match_cast

      channel_options = {
            class_name: 'CastContext::Channel',
            foreign_key: :channel_id,
            inverse_of: :match_casts,
            optional: true
          }
      belongs_to :channel, channel_options
    end

  end
end

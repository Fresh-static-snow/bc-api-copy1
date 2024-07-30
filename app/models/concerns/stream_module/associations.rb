# frozen_string_literal: true

module StreamModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_many :match_casts, foreign_key: :cast_stream_id, dependent: :destroy, inverse_of: :stream
    end

  end
end

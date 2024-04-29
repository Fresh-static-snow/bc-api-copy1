# frozen_string_literal: true

module StudioModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_many :match_casts, foreign_key: :cast_studio_id, dependent: :destroy, inverse_of: :studio
    end

  end
end

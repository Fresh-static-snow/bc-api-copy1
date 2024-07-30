# frozen_string_literal: true

module SetupModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_many :match_casts, foreign_key: :cast_setup_id, dependent: :destroy, inverse_of: :setup
    end

  end
end

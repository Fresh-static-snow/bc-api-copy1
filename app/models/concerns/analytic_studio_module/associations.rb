# frozen_string_literal: true

module AnalyticStudioModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_many :match_casts, foreign_key: :cast_analytic_studio_id, dependent: :destroy, inverse_of: :analytic_studio
    end

  end
end

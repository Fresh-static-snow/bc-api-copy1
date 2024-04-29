# frozen_string_literal: true

module RegionModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[name].freeze

    included do
      validates_presence_of MANDATORY_FIELDS

      validates :name, length: { in: 1..250 }
      delegate :present?, to: :code, prefix: true, allow_nil: true
      validates :code, length: { in: 1..250 }, if: :code_present?
    end

  end
end

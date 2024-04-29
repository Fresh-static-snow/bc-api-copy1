# frozen_string_literal: true

module RoleModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[title permissions].freeze

    included do
      validates_presence_of MANDATORY_FIELDS

      validates :title, length: { in: 1..250 }
      delegate :present?, to: :description, prefix: true, allow_nil: true
      validates :description, length: { in: 1..250 }, if: :description_present?
    end

  end
end

# frozen_string_literal: true

module LanguageModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[name].freeze

    included do
      validates_presence_of MANDATORY_FIELDS

      validates :name, length: { in: 1..250 }
      delegate :present?, to: :keyword, prefix: true, allow_nil: true
      validates :keyword, length: { in: 1..250 }, if: :keyword_present?
    end

  end
end

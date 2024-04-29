# frozen_string_literal: true

module GameDisciplineModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[title].freeze
    CONTENT_TYPES = %w[image/png image/jpg image/jpeg image/svg+xml].freeze
    COVER_SIZE_LIMIT = 61_440

    included do
      validates_presence_of MANDATORY_FIELDS

      validates :cover,
                content_type: self::CONTENT_TYPES,
                size: { less_than: self::COVER_SIZE_LIMIT.kilobytes }

      validates :title, length: { in: 1..250 }
      delegate :present?, to: :keyword, prefix: true, allow_nil: true
      validates :keyword, length: { in: 1..250 }, if: :keyword_present?
      validates :order, numericality: { only_integer: true }, allow_nil: true
    end

  end
end

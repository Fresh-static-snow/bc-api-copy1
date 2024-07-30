# frozen_string_literal: true

module SegmentModule
  module Validations

    extend ActiveSupport::Concern

    included do
      validate :cover_presence
      validates :logo,
                content_type: self::CONTENT_TYPES,
                size: { less_than: self::COVER_SIZE_LIMIT.kilobytes },
                presence: false

      private

      def cover_presence
        errors.add(:cover, 'must be attached') unless cover.attached?
      end
    end

  end
end

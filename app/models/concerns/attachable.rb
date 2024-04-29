# frozen_string_literal: true

module Attachable

  CONTENT_TYPES = %w[image/png image/jpg image/jpeg image/svg+xml].freeze
  COVER_SIZE_LIMIT = 61_440

  extend ActiveSupport::Concern

  included do
    has_one_attached :cover, dependent: :purge_later

    validates :cover,
              content_type: self::CONTENT_TYPES,
              size: { less_than: self::COVER_SIZE_LIMIT.kilobytes }
  end

end

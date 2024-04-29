# frozen_string_literal: true

module TeamModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[name game_discipline_id].freeze

    included do
      validates_presence_of MANDATORY_FIELDS

      validates :name, length: { in: 1..250 }
      delegate :present?, to: :keyword, prefix: true, allow_nil: true
      validates :keyword, length: { in: 1..250 }, if: :keyword_present?

      validate :validate_game_discipline_exist

      def validate_game_discipline_exist
        errors.add(:game_discipline_id, 'does not exist') \
          unless GameDiscipline.exists?(id: game_discipline_id)
      end
    end

  end
end

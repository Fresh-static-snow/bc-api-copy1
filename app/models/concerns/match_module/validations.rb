# frozen_string_literal: true

module MatchModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[tournament_id].freeze

    included do
      validates_presence_of MANDATORY_FIELDS

      delegate :present?, to: :best_of, prefix: true, allow_nil: true
      validates :best_of, numericality: { only_integer: true, greater_than: 0 }, if: :best_of_present?
      validates :visible, inclusion: { in: [true, false] }
      delegate :present?, to: :start_at, prefix: true, allow_nil: true
      validates :start_at, timeliness: { type: :datetime }, if: :start_at_present?
      delegate :present?, to: :end_at, prefix: true, allow_nil: true
      validates :end_at, timeliness: { type: :datetime }, if: :end_at_present?
      validates :team_one_id,
                numericality: { only_integer: true, greater_than: 0 },
                if: -> { :team_one_id.present? }, allow_nil: true
      validates :team_two_id,
                numericality: { only_integer: true, greater_than: 0 },
                if: -> { :team_one_id.present? }, allow_nil: true
      validates :team_one_title, length: { in: 1..250 }, if: -> { :team_one_id.blank? }
      validates :team_two_title, length: { in: 1..250 }, if: -> { :team_two_id.blank? }
      validates :tournament_id, presence: true

      validate :validate_tournament_exist

      delegate :present?, to: :team_one_id, prefix: true, allow_nil: true
      validate :validate_team_one_exist, if: :team_one_id_present?
      delegate :present?, to: :team_two_id, prefix: true, allow_nil: true
      validate :validate_team_two_exist, if: :team_two_id_present?

      private

      def validate_team_one_exist
        errors.add(:team_one_id, 'Team with such id does not exist') unless Team.exists?(id: team_one_id)
      end

      def validate_team_two_exist
        errors.add(:team_two_id, 'Team with such id does not exist') unless Team.exists?(id: team_two_id)
      end

      def validate_tournament_exist
        unless Tournament.exists?(id: tournament_id)
          errors.add(:tournament_id, 'Tournament with such id does not exist')
        end
      end
    end

  end
end

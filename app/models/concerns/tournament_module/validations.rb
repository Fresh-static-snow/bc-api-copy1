# frozen_string_literal: true

module TournamentModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[title game_discipline_id start_at].freeze

    included do
      validates_presence_of MANDATORY_FIELDS
      validates :start_at, presence: true, timeliness: { type: :datetime }
      delegate :present?, to: :end_at, prefix: true, allow_nil: true
      validates :end_at, timeliness: { type: :datetime }, if: :end_at_present?
      validates :title, length: { in: 1..250 }

      validates :visible, inclusion: { in: [true, false] }
      validates :owner_id, numericality: { only_integer: true }, allow_nil: true
      validates :region_id, numericality: { only_integer: true }, allow_nil: true
      validates :type_id, numericality: { only_integer: true }, allow_nil: true
      validates :top, numericality: {
        only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3
      }, allow_nil: true

      validate :validate_game_discipline_exist
      validate :validate_main_participant
      validate :validate_media_representative
      validate :validate_sponsors_exist
      validate :validate_owner_exist
      validate :validate_region_exist
      validate :validate_type_exist

      private

      def validate_game_discipline_exist
        errors.add(:game_discipline_id, 'does not exist') \
          unless GameDiscipline.exists?(id: game_discipline_id)
      end

      def validate_sponsors_exist
        # sponsor_ids.each do |sponsor_id|
        #   next if Sponsor.exists?(id: sponsor_id)
        #
        #   errors.add(:main_participant_ids, "Sponsor with ID #{sponsor_id} does not exist")
        # end
      end

      def validate_main_participant
        main_participant_ids.each do |participant_id|
          next if User.includes(:user_disciplines)
                      .where(user_disciplines: { title: 'Main Participant' })
                      .exists?(id: participant_id)

          errors.add(:main_participant_ids, "Main participant with ID #{participant_id} does not exist")
        end
      end

      def validate_media_representative
        media_representative_ids.each do |representative_id|
          next if User.includes(:user_disciplines)
                      .where(user_disciplines: { title: 'Media Representative' })
                      .exists?(id: representative_id)

          errors.add(:media_representative_ids, "Media representative with ID #{representative_id} does not exist")
        end
      end

      def validate_region_exist
        errors.add(:region_id, 'does not exist') if region_id.present? && !Region.exists?(id: region_id)
      end

      def validate_owner_exist
        if owner_id.present? &&
           !User.includes(:user_disciplines)
                .where(user_disciplines: { title: 'Manager' })
                .exists?(id: owner_id)
          errors.add(:owner_id, 'does not exist')
        end
      end

      def validate_type_exist
        errors.add(:type_id, 'does not exist') if type_id.present? && !TournamentContext::Type.exists?(id: type_id)
      end

      def validate_ui_template_json
        nil if ui_template.blank?
      rescue JSON::ParserError
        errors.add(:ui_template, 'must be a valid JSON')
      end
    end

  end
end

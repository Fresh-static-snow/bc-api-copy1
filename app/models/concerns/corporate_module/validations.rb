# frozen_string_literal: true

module CorporateModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[name start_at company_id].freeze

    included do
      validates_presence_of MANDATORY_FIELDS
      validates :name, length: { in: 1..250 }
      delegate :present?, to: :description, prefix: true, allow_nil: true
      validates :description, length: { minimum: 1 }, if: :description_present?
      delegate :present?, to: :location, prefix: true, allow_nil: true
      validates :location, length: { in: 1..250 }, if: :location_present?
      validates :visible, inclusion: { in: [true, false] }
      validates :start_at, presence: true, timeliness: { type: :datetime }
      delegate :present?, to: :end_at, prefix: true, allow_nil: true
      validates :end_at, timeliness: { type: :datetime }, if: :end_at_present?

      delegate :present?, to: :company_id, prefix: true, allow_nil: true
      validate :validate_company_exist, if: :company_id_present?

      private

      def validate_company_exist
        errors.add(:company_id, 'does not exist') unless CorporateCompany.exists?(id: company_id)
      end
    end

  end
end

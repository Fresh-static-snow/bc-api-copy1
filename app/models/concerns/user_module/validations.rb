# frozen_string_literal: true

module UserModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[email].freeze

    included do
      validates_presence_of MANDATORY_FIELDS

      validates :avatar,
                content_type: %w[image/png image/jpg image/jpeg image/svg+xml].freeze,
                size: { less_than: 1024.kilobytes }

      validates :email, uniqueness: true
      validate :validate_name_exist

      validates :roles, presence: true, unless: :recovering?

      delegate :present?, to: :company_id, prefix: true, allow_nil: true
      validate :validate_company_exist, if: :company_id_present?

      validate :validate_time_zone

      private

      def validate_name_exist
        if nick.blank? && (first_name.blank? && last_name.blank?)
          errors.add(nick.blank? ? :nick : :first_name, 'At least one of first_name, last_name, or nick must exist')
        end
      end

      def validate_company_exist
        errors.add(:company_id, 'does not exist') unless UserCompany.exists?(id: company_id)
      end

      def validate_time_zone
        errors.add(:time_zone, 'is not a valid time zone') unless ActiveSupport::TimeZone.new(time_zone)
      end

      def recovering?
        changes[:deleted_at].present?
      end
    end

  end
end

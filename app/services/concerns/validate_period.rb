# frozen_string_literal: true

module ValidatePeriod

  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations

    validate :validate_period_from
    validate :validate_period_to
    validate :validate_focused_date

    private

    def validate_datetime(attribute)
      return unless send("#{attribute}_present?")

      errors.add(attribute, 'must be a valid datetime') unless send(attribute).is_a?(DateTime)
    end

    def validate_period_from
      validate_datetime(:period_from)
    end

    def validate_period_to
      validate_datetime(:period_to)
    end

    def validate_focused_date
      validate_datetime(:focused_date)
    end
  end

end

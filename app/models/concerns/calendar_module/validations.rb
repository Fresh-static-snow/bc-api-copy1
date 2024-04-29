# frozen_string_literal: true

module CalendarModule
  module Validations

    extend ActiveSupport::Concern

    included do
      delegate :present?, to: :period_from, prefix: true, allow_nil: true
      validates :period_from, timeliness: { type: :datetime }, if: :period_from_present?

      delegate :present?, to: :period_to, prefix: true, allow_nil: true
      validates :period_to, timeliness: { type: :datetime }, if: :period_to_present?

      delegate :present?, to: :focused_date, prefix: true, allow_nil: true
      validates :focused_date, timeliness: { type: :datetime }, if: :focused_date_present?
    end

  end
end

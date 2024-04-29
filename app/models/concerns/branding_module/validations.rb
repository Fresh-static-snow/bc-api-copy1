# frozen_string_literal: true

module BrandingModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[name].freeze

    included do
      validates_presence_of MANDATORY_FIELDS

      validates :name, length: { in: 1..250 }
    end

  end
end

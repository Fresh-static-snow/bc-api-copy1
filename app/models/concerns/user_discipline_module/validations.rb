# frozen_string_literal: true

module UserDisciplineModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[title].freeze

    included do
      validates_presence_of MANDATORY_FIELDS
      validates :title, length: { in: 1..250 }
    end

  end
end

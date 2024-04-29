# frozen_string_literal: true

module EntityCommentModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[message entity_type entity_id].freeze

    # attachment: + svg

    included do
      validates_presence_of MANDATORY_FIELDS
      validates :message, presence: true, length: { in: 1..1500 }
      validates :entity_type, presence: true, length: { in: 1..50 }
      validates :entity_id, presence: true, numericality: { only_integer: true }
    end

  end
end

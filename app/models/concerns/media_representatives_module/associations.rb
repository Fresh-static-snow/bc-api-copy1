# frozen_string_literal: true

module MediaRepresentativesModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :tournament
      belongs_to :user
    end

  end
end

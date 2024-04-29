# frozen_string_literal: true

module DescriptionModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :tournament
    end

  end
end

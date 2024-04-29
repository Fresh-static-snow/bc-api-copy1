# frozen_string_literal: true

module CorporateModule
  module Colorable

    extend ActiveSupport::Concern

    module ClassMethods

      AVAILABLE_COLORS = {
        '0' => { primary: '#F4252D' }
      }.freeze

    end

    included do
      include ClassMethods
    end

  end
end

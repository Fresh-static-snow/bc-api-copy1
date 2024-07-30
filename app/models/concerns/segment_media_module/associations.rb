# frozen_string_literal: true

module SegmentMediaModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :segment
    end

  end
end

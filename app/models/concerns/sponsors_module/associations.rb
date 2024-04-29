# frozen_string_literal: true

module SponsorsModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :sponsor
      belongs_to :tournament
    end

  end
end

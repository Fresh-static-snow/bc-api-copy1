# frozen_string_literal: true

module RegionModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_many :tournaments, dependent: :destroy
    end

  end
end

# frozen_string_literal: true

module TypeModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_many :tournaments, dependent: :destroy
    end

  end
end

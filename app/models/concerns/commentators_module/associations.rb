# frozen_string_literal: true

module CommentatorsModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :match_cast
      belongs_to :user
    end

  end
end

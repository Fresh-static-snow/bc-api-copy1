# frozen_string_literal: true

module HostAnalyticModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :user, optional: true
      belongs_to :match_cast
    end

  end
end

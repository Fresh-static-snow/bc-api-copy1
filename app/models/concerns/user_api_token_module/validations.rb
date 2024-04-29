# frozen_string_literal: true

module UserApiTokenModule
  module Validations

    extend ActiveSupport::Concern

    MANDATORY_FIELDS = %i[access_token refresh_token].freeze

    included do
      validates_presence_of MANDATORY_FIELDS
    end

  end
end

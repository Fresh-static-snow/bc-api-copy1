# frozen_string_literal: true

module UserRoleModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :user
      belongs_to :role
    end

  end
end

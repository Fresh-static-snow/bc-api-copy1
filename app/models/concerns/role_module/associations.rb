# frozen_string_literal: true

module RoleModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_many :user_roles, dependent: :destroy
      has_many :users, through: :user_roles
    end

  end
end

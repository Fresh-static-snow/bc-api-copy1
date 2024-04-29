# frozen_string_literal: true

module UserDisciplineModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_many :user_discipline_memberships, dependent: :destroy
      has_many :users, through: :user_discipline_memberships
    end

  end
end

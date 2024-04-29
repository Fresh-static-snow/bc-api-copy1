# frozen_string_literal: true

module UserDisciplineMembershipModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :user
      belongs_to :user_discipline
    end

  end
end

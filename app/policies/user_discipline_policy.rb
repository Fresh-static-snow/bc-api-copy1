# frozen_string_literal: true

class UserDisciplinePolicy < ApplicationPolicy

  def index?
    user.present?
  end

end

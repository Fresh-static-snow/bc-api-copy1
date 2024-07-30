# frozen_string_literal: true

class AccountSettingPolicy < ApplicationPolicy

  def show?
    true
  end

  def update?
    true
  end

end

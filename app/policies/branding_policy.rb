# frozen_string_literal: true

class BrandingPolicy < ApplicationPolicy

  def main?
    user.present?
  end

  def change?
    update?
  end

end

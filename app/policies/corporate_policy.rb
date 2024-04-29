# frozen_string_literal: true

class CorporatePolicy < ApplicationPolicy

  def comments?
    show?
  end

  def only_visible?
    permission?(:visible)
  end

end

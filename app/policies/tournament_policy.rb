# frozen_string_literal: true

class TournamentPolicy < ApplicationPolicy

  def media?
    show?
  end

  def schedule?
    show?
  end

  def comments?
    show?
  end

  def types?
    show?
  end

  def only_visible?
    permission?(:visible)
  end

end

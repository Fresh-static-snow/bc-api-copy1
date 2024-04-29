# frozen_string_literal: true

class MatchPolicy < ApplicationPolicy

  def types?
    index?
  end

  def only_visible?
    permission?(:visible)
  end

  def bulk_destroy?
    record.any?(&:deleted?)
  end

  def bulk_restore?
    record.any?(&:deleted?)
  end

  def bulk_soft_destroy?
    true
  end

end

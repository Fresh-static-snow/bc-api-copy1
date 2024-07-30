# frozen_string_literal: true

class SegmentPolicy < MatchPolicy

  def media?
    show?
  end

  def comments?
    show?
  end

  def types?
    show?
  end

end

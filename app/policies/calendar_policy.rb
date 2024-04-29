# frozen_string_literal: true

class CalendarPolicy < ApplicationPolicy

  def day
    permission?(:day)
  end

  def week
    permission?(:week)
  end

  def month
    permission?(:month)
  end

  def quarter
    permission?(:quarter)
  end

  def year
    permission?(:year)
  end

end

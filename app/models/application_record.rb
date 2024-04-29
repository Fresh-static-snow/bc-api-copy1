# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  before_validation :strip_whitespace

  private

  def strip_whitespace
    attributes.each do |attr, value|
      self[attr] = value.strip if value.respond_to?(:strip)
    end
  end

end

# frozen_string_literal: true

class Base

  attr_accessor :errors

  def initialize
    @errors = {}
  end

  private

  def with_transaction
    ActiveRecord::Base.transaction do
      yield

      raise ActiveRecord::Rollback if errors.any?
    end
  end

  def collect_errors(*resources)
    resources.each do |resource|
      errors[resource.class.name.downcase.to_sym] = resource.errors.messages.transform_values(&:uniq) if resource.errors.any?
    end
  end

  def success
    @success = true
  end

  def failure(error_message)
    @errors[:base] = error_message
    @success = false
  end

end

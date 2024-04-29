# frozen_string_literal: true

class BaseShowService

  attr_reader :resource

  def self.call(resource)
    new(resource).call
  end

  def initialize(resource)
    @resource = resource
  end

  def call
    raise NotImplementedError, "Subclasses must implement the 'call' method."
  end

end

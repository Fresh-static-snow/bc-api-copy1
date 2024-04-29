# frozen_string_literal: true

class BaseDeleteService < Base

  attr_accessor :resource

  def self.call(resource)
    new(resource).call
  end

  def initialize(resource)
    @resource = resource

    super()
  end

  def call
    with_transaction do
      delete_resource
    end

    collect_errors(resource)

    resource
  end

  private

  def delete_resource
    resource.destroy_fully!
  end

end

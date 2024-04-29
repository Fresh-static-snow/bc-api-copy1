# frozen_string_literal: true

class BaseUpdateService < Base

  attr_reader :resource, :params

  def self.call(resource, params)
    new(resource, params).call
  end

  def initialize(resource, params)
    @resource = resource
    @params = params

    super()
  end

  def call
    with_transaction do
      update_resource
    end

    collect_errors(resource)

    resource
  end

  private

  def update_resource
    resource.update(params)
  end

end

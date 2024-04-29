# frozen_string_literal: true

class BaseCreateService < Base

  attr_reader :resource, :params

  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params = params

    super()
  end

  def call
    with_transaction do
      create_resource
    end

    collect_errors(resource)

    resource
  end

  private

  def create_resource
    @resource = resource_class.create(params)
  end

  def resource_class
    subclass_name = self.class.to_s
    resource_name = subclass_name.split('::').reject { |name| name == 'Create' }.join('::')
    resource_name.constantize
  end

end

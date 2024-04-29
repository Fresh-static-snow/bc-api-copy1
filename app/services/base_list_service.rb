# frozen_string_literal: true

class BaseListService

  include DeletedContext

  attr_reader :params

  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params = params.except(:page, :per_page)
  end

  def call
    raise NotImplementedError, "Subclasses must implement the 'call' method."
  end

  def resource
    @resource = only_deleted? ? deleted_resource : resource_class.filter(params.except(:with_history))
  end

  private

  def resource_class
    subclass_name = self.class.to_s
    resource_name = subclass_name.split('::').reject { |name| name == 'List' }.join('::')
    resource_name.constantize
  end

end

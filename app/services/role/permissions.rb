# frozen_string_literal: true

class Role
  class Permissions < Base

    def self.call(params)
      new(params).call
    end

    def call
      PermissionSerializer.render_as_hash(resources, view: :list)
    end

    private

    attr_reader :params

    def initialize(params)
      @params = params.except(:page, :per_page)
    end

    def resources
      PermissionService.permissions.filter { |p| p[:target_type] == :special }
    end

  end
end

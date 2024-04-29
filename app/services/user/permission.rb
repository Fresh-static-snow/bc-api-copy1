# frozen_string_literal: true

class User
  class Permission < Base

    def self.call(user)
      new(user).call
    end

    def call
      permissions = PermissionService.generate_user_permissions(@user.roles)
      routes = []
      permissions.map do |_k, permission|
        routes << permission[:allowed_routes]
      end

      {
        permissions: permissions,
        routes: routes.flatten.uniq
      }
    end

    private

    attr_reader :user

    def initialize(user)
      @user = user
    end

  end
end

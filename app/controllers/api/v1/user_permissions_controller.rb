# frozen_string_literal: true

module Api
  module V1
    class UserPermissionsController < ApplicationController

      def permissions
        authorize current_user

        data = User::Permission.call(current_user)
        render_json_response(true, data, :ok)
      end

    end
  end
end

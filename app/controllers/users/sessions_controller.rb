# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController

    respond_to :json

    def create
      super do |resource|
        if resource.errors.empty?
          if current_user.roles.blank?
            sign_out(current_user)
            render nothing: true, status: :unauthorized
          end

          render_json_response(true, UserSerializer.render_as_hash(resource, view: :show), :created)
        else
          render_json_response(true, resource.errors.full_messages, :unprocessable_entity)
        end

        return
      end
    end

  end
end

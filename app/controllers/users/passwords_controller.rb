# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController

    respond_to :json

    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)

      render_json_response(true, {}, :ok)
    end

    def update # rubocop:disable Metrics/AbcSize
      self.resource = resource_class.reset_password_by_token(resource_params)
      yield resource if block_given?

      if resource.errors.empty?
        resource.unlock_access! if unlockable?(resource)

        resource.remember_me = true
        sign_in(resource_name, resource)

        render_json_response(true, UserSerializer.render_as_hash(resource, view: :show), :ok)
      else
        render_json_response(false, resource.errors.full_messages, :unprocessable_entity)
      end
    end

  end
end

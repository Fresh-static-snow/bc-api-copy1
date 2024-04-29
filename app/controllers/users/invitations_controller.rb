# frozen_string_literal: true

module Users
  class InvitationsController < Devise::InvitationsController

    respond_to :json

    def update # rubocop:disable Metrics/AbcSize
      self.resource = accept_resource
      invitation_accepted = resource.errors.empty?

      yield resource if block_given?

      if invitation_accepted
        resource.remember_me = true
        sign_in(resource_name, resource)

        render_json_response(true, UserSerializer.render_as_hash(resource, view: :show), :ok)
      else
        render_json_response(false, resource.errors.full_messages, :unprocessable_entity)
      end
    end

  end
end

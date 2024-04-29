# frozen_string_literal: true

module Auth

  extend ActiveSupport::Concern

  included do
    include ActionController::MimeResponds
    include Pundit::Authorization

    before_action :check_format
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :check_user_roles

    private

    def check_format
      unless params[:format] || request.headers['Accept'] == 'application/json'
        render nothing: true,
               status: :unauthorized
      end
    end

    def check_user_roles
      if current_user && current_user&.roles.blank?
        sign_out(current_user)
        render nothing: true, status: :unauthorized
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in) do |user_params|
        user_params.permit(:email, :password)
      end
      devise_parameter_sanitizer.permit(:sign_up) do |user|
        user.permit(:email, :password)
      end
    end
  end

end

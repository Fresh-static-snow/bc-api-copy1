# frozen_string_literal: true

class User
  class AddCalendarAccess

    attr_reader :current_user, :token_params

    def self.call(current_user, token_params)
      new(current_user, token_params).call
    end

    def initialize(current_user, token_params)
      @current_user = current_user
      @token_params = token_params
    end

    def call
      user_api_token = UserApiToken.find_or_create_by(user: current_user)
      user_api_token.update(token_params)
    end

  end
end

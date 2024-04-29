# frozen_string_literal: true

class User
  class ChangePassword < Base

    def self.call(user, password_params)
      new(user, password_params).call
    end

    def call
      change_password
    end

    private

    attr_reader :user, :password_params

    def initialize(user, password_params)
      @user = user
      @password_params = password_params
    end

    def change_password
      if @user.update_with_password(password_params)
        @user.send_password_change_notification
        { success: true, message: 'Password successfully changed.' }
      else
        { success: false, error: @user.errors.full_messages.join(', ') }
      end
    end

  end
end

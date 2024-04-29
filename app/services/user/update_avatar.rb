# frozen_string_literal: true

class User
  class UpdateAvatar < Base

    def self.call(user, user_params)
      new(user, user_params).call
    end

    def call
      with_transaction do
        update_user
      end

      collect_errors(user)

      user
    end

    private

    attr_reader :user, :user_params

    def initialize(user, user_params)
      @user = user
      @user_params = user_params

      super()
    end

    def update_user
      user.update(user_params)
    end

  end
end

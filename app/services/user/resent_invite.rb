# frozen_string_literal: true

class User
  class ResentInvite < Base

    def self.call(user)
      new(user).call
    end

    def call
      user.invite!

      user
    end

    private

    attr_reader :user

    def initialize(user)
      @user = user
    end

  end
end

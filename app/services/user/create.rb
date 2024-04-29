# frozen_string_literal: true

class User
  class Create < Base

    include SendNotify

    attr_accessor :resource, :current_user

    def self.call(user_params, current_user)
      new(user_params, current_user).call
    end

    def call
      with_transaction do
        create_user
      end

      collect_errors(resource)

      send_admin_notify(resource, :create, false) unless resource.errors.any?

      resource
    end

    private

    attr_reader :user_params

    def initialize(user_params, current_user)
      @user_params = user_params
      @current_user = current_user

      super()
    end

    def create_user
      @resource = User.new(user_params)
      @resource.invite! if @resource.save
    end

  end
end

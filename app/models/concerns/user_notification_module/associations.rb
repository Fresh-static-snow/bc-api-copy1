# frozen_string_literal: true

module UserNotificationModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :user
      belongs_to :author, class_name: 'User'
    end

  end
end

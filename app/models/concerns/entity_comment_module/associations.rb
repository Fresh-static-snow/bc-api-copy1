# frozen_string_literal: true

module EntityCommentModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :user
    end

  end
end

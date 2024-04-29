# frozen_string_literal: true

module BackupCommentatorModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :match_cast
      belongs_to :user, optional: true
    end

  end
end

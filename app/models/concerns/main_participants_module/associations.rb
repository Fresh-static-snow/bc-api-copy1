# frozen_string_literal: true

module MainParticipantsModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :tournament
      belongs_to :user, with_deleted: true
    end

  end
end

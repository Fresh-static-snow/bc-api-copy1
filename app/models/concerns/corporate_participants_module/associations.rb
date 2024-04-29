# frozen_string_literal: true

module CorporateParticipantsModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :corporate
      belongs_to :user, with_deleted: true
    end

  end
end

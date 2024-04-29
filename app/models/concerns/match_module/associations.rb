# frozen_string_literal: true

module MatchModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :tournament, with_deleted: true
      belongs_to :team_one, class_name: 'Team', optional: true
      accepts_nested_attributes_for :team_one
      belongs_to :team_two, class_name: 'Team', optional: true
      accepts_nested_attributes_for :team_two

      has_many :match_casts, dependent: :destroy
      accepts_nested_attributes_for :match_casts, allow_destroy: true
      alias_method :casts, :match_casts
    end

  end
end

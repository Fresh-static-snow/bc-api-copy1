# frozen_string_literal: true

module SponsorModule
  module Associations

    extend ActiveSupport::Concern

    included do
      has_many :tournament_sponsors, class_name: 'TournamentContext::Sponsors', dependent: :destroy
      has_many :tournaments, through: :tournament_sponsors
    end

  end
end

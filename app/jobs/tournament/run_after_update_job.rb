# frozen_string_literal: true

class Tournament
  class RunAfterUpdateJob < ApplicationJob

    queue_as :default

    def perform(tournament)
      tournament.matches&.each do |match|
        Match::RunAfterUpdateJob.perform_later(match)
      end
    end

  end
end

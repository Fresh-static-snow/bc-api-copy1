# frozen_string_literal: true

class Tournament
  class RunBeforeDestroyJob < ApplicationJob

    queue_as :default

    def perform(tournament)
      tournament.matches&.each do |match|
        Match::RunBeforeDestroyJob.perform_later(match)
      end
    end

  end
end

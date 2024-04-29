# frozen_string_literal: true

class Match
  class RunBeforeDestroyJob < ApplicationJob

    queue_as :default

    def perform(match)
      match.google_event_ids&.map do |k, v|
        token = User.find(k).user_api_token
        GoogleApi::CalendarV3::Delete.call(v, token) if token.present?
      end

      match.update_column(:google_event_ids, nil) # rubocop:disable Rails/SkipsModelValidations
    end

  end
end

# frozen_string_literal: true

class Match
  class RunAfterCreateJob < ApplicationJob

    queue_as :default

    include GoogleEventDescription

    def perform(match) # rubocop:disable Metrics/AbcSize
      return unless match.visible == true && match.tournament.visible == true

      event_params = {
        start_at: match.start_at,
        end_at: match.end_at,
        title: "#{match.tournament&.title}: #{match.team_one&.name} vs #{match.team_two&.name}",
        description: description(match)
      }

      google_event_ids = []

      users = match.match_casts.flat_map do |match_casts|
        [
          match_casts.match_analytics,
          match_casts.match_commentators,
          match_casts.match_staff_members
        ].flat_map do |association|
          association.map { |item| item.user if item.user&.user_api_token.present? }
        end.compact
      end.uniq
      users.map do |user|
        event_params[:time_zone] = user.time_zone
        google_calendar_event_id = GoogleApi::CalendarV3::Create.call(user.user_api_token, event_params)

        next if google_calendar_event_id.blank?

        google_event_ids << {
          user.id => google_calendar_event_id
        }
      end

      google_event_ids = google_event_ids.reduce({}, :merge)
      match_google_event_ids = google_event_ids.presence
      match.update_column(:google_event_ids, match_google_event_ids) # rubocop:disable Rails/SkipsModelValidations
    end

  end
end

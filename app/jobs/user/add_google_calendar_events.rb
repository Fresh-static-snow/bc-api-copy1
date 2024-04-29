# frozen_string_literal: true

class User
  class AddGoogleCalendarEvents < ApplicationJob

    queue_as :default

    include GoogleEventDescription

    def perform(user) # rubocop:disable Metrics/AbcSize
      return if user.user_api_token.blank?

      matches_ids = user.match_analytic_casts.pluck(:match_id) +
                    user.match_commentator_casts.pluck(:match_id) +
                    user.match_staff_member_casts.pluck(:match_id)

      Match.where(id: matches_ids).find_each do |match|
        next unless match.visible == true || match.tournament.visible == true

        event_params = {
          start_at: match.start_at,
          end_at: match.end_at,
          title: "#{match.tournament&.title}: #{match.team_one&.name} vs #{match.team_two&.name}",
          description: description(match),
          time_zone: user.time_zone
        }

        google_calendar_event_id = GoogleApi::CalendarV3::Create.call(user.user_api_token, event_params)

        next if google_calendar_event_id.blank?

        google_event_ids = match.google_event_ids || {}
        google_event_ids[user.id] = google_calendar_event_id

        match_google_event_ids = google_event_ids.presence
        match.update_column(:google_event_ids, match_google_event_ids) # rubocop:disable Rails/SkipsModelValidations
      end
    end

  end
end

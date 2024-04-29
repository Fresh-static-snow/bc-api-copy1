# frozen_string_literal: true

class Match
  class RunAfterUpdateJob < ApplicationJob

    queue_as :default

    include GoogleEventDescription

    def perform(match) # rubocop:disable Metrics/AbcSize
      event_params = {
        start_at: match.start_at,
        end_at: match.end_at,
        title: "#{match.tournament&.title}: #{match.team_one&.name} vs #{match.team_two&.name}",
        description: description(match)
      }

      users = match.match_casts.flat_map do |match_casts|
        [
          match_casts.match_analytics,
          match_casts.match_commentators,
          match_casts.match_staff_members
        ].flat_map do |association|
          association.map { |item| item.user if item.user&.user_api_token.present? }
        end.compact
      end.uniq

      old_user_ids = (match.google_event_ids&.keys || []).map(&:to_i)

      if match.visible == true && match.tournament.visible == true
        current_user_ids = users.map(&:id) || []

        users_added = current_user_ids - old_user_ids
        users_deleted = old_user_ids - current_user_ids
        users_updated = current_user_ids - users_added - users_deleted
      else
        users_added = []
        users_deleted = old_user_ids
        users_updated = []
      end

      google_event_ids = []

      users_added.map do |u_id|
        user = User.find(u_id)
        event_params[:time_zone] = user.time_zone
        google_calendar_event_id = GoogleApi::CalendarV3::Create.call(user.user_api_token, event_params)

        next if google_calendar_event_id.blank?

        google_event_ids << {
          u_id => google_calendar_event_id
        }
      end

      users_deleted.map do |u_id|
        user_api_token = User.find(u_id).user_api_token
        GoogleApi::CalendarV3::Delete.call(match.google_event_ids[u_id.to_s], user_api_token) if user_api_token.present?
      end

      users_updated.map do |u_id|
        user = User.find(u_id)
        event_params[:time_zone] = user.time_zone

        next if user.user_api_token.blank?

        google_calendar_event_id = GoogleApi::CalendarV3::Update.call(
          match.google_event_ids[u_id.to_s], user.user_api_token, event_params
        )

        if google_calendar_event_id.blank?
          google_calendar_event_id = GoogleApi::CalendarV3::Create.call(user.user_api_token, event_params)
        end

        next if google_calendar_event_id.blank?

        google_event_ids << {
          u_id => google_calendar_event_id
        }
      end

      google_event_ids = google_event_ids.reduce({}, :merge)
      match_google_event_ids = google_event_ids.presence
      match.update_column(:google_event_ids, match_google_event_ids) # rubocop:disable Rails/SkipsModelValidations
    end

  end
end

# frozen_string_literal: true

class User
  class DestroyGoogleCalendarEvents < ApplicationJob

    queue_as :default

    def perform(user) # rubocop:disable Metrics/AbcSize
      user_api_token = UserApiToken.with_deleted.where(user_id: user.id)&.first
      return if user_api_token.blank?

      matches_ids = MatchCast.with_deleted
                             .joins("INNER JOIN match_analytics ON match_casts.id = match_analytics.match_cast_id")
                             .where("match_analytics.user_id": user.id)
                             .pluck(:match_id)
      matches_ids +=
        MatchCast.with_deleted
                 .joins("INNER JOIN match_commentators ON match_casts.id = match_commentators.match_cast_id")
                 .where("match_commentators.user_id": user.id)
                 .pluck(:match_id)

      matches_ids +=
        MatchCast.with_deleted
                 .joins("INNER JOIN match_staff_members ON match_casts.id = match_staff_members.match_cast_id")
                 .where("match_staff_members.user_id": user.id)
                 .pluck(:match_id)

      Match.where(id: matches_ids).find_each do |match|
        google_event_ids = match.google_event_ids
        u_id = user.id.to_s
        next if google_event_ids.blank? || google_event_ids[u_id].blank?

        GoogleApi::CalendarV3::Delete.call(google_event_ids[u_id], user_api_token)

        google_event_ids.delete(u_id)

        match_google_event_ids = google_event_ids.presence
        match.update_column(:google_event_ids, match_google_event_ids) # rubocop:disable Rails/SkipsModelValidations
      end
    end

  end
end

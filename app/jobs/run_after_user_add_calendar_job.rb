# frozen_string_literal: true

class RunAfterUserAddCalendarJob < ApplicationJob

  queue_as :default

  def perform(user)
    matches(user)&.each do |match|
      if match.visible == true && match.tournament.visible == true
        Match::RunAfterUpdateJob.perform_later(match)
      else
        Match::RunBeforeDestroyJob.perform_later(match)
      end
    end
  end

  private

  def matches(user)
    match_casts = user.match_commentators + user.match_analytics + user.match_staff_members

    match_casts&.filter_map do |cast|
      cast.match_cast.match if cast.match_cast.match.start_at >= Time.zone.now
    end
  end

end

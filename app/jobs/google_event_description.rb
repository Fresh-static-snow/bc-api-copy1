# frozen_string_literal: true

module GoogleEventDescription

  private

  def description(match) # rubocop:disable Metrics/AbcSize
    description = ""
    match.match_casts.map do |cast|
      link = ENV.fetch('BASE_FRONT_URL', 'http://localhost:9000')
      link += "/calendar/day?start_at=#{match.start_at.to_date}&current_user=true\n\n"
      language = "Language: #{cast.language&.name}\n"
      studio = "Studio: #{cast.studio&.name}\n"
      setup = "Setup: #{cast.setup&.name}\n"
      stream = "Stream: #{cast.stream&.name}\n"
      analytic_studio = "Analytic Studio: #{cast.analytic_studio&.name}\n"
      channels = "Channels: #{cast.channels.pluck(:name).join(', ')}\n"

      description += "#{link}#{language}#{studio}#{analytic_studio}#{setup}#{stream}#{channels}\n"

      commentators = []
      cast.match_commentators.map do |a|
        commentators << a.user.display_name
      end

      analytics = []
      cast.match_analytics.map do |a|
        analytics << a.user.display_name
      end

      staff = []
      cast.match_staff_members.map do |a|
        staff << a.user.display_name
      end

      description += "Match Commentators: #{commentators.join(', ')}\n"
      description += "Match Analytics: #{analytics.join(', ')}\n"
      description += "Match Staff Members: #{staff.join(', ')}"

      description += "\n\n"
    end

    description
  end

end

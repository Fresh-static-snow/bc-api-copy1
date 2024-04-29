# frozen_string_literal: true

module BotsNotification
  class TournamentNotifiable < BotsNotification::Notifiable

    attr_reader :tournament, :match_casts, :user_discipline

    def initialize(resource, user, action_name)
      super(resource, user, action_name)

      @user_discipline = user_discipline
    end

    private

    def message_text # rubocop:disable Metrics/AbcSize
      message = "#{action_icon} Турнір: #{resource.title} \n"
      message += "💥 Дисципліна: #{resource.game_discipline.title} \n"
      message += date_time_message
      message += link_message
      message += "Спонсори: #{resource.sponsors.pluck(:name).join(', ')} \n"
      message += "Main Participants: #{resource.main_participants.map(&:display_name).join(', ')} \n"
      message += "Media Representatives: #{resource.media_representatives.map(&:display_name).join(', ')} \n"
      message
    end

    def date_time_message
      "⏰ Дата і час: #{resource.start_at.strftime('%Y-%m-%d | %H:%M')}#{resource.end_at&.strftime(' - %H:%M')} \n"
    end

    def link_message
      "[Посилання на турнір](#{ENV['BASE_FRONT_URL']}/calendar/tournament/#{resource.id}/main) \n"
    end

  end
end

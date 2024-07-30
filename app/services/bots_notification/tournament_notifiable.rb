# frozen_string_literal: true

module BotsNotification
  class TournamentNotifiable < BotsNotification::Notifiable

    attr_reader :tournament, :match_casts, :user_discipline

    def initialize(resource, action_name)
      super(resource, action_name)

      @user_discipline = user_discipline
    end

    def message_text # rubocop:disable Metrics/AbcSize
      message = "#{action_icon} Турнір: #{resource.title.gsub(/_/, '\_')} \n"
      message += "💥 Дисципліна: #{resource.game_discipline.title} \n"
      message += date_time_message
      message += link_message
      message += "Спонсори: #{resource.sponsors.pluck(:name).join(', ')} \n"
      message += "Відповідальний менеджер: #{resource.main_participants.map(&:display_name).join(', ')} \n"
      message += "Відповідальний за медіа: #{resource.media_representatives.map(&:display_name).join(', ')} \n"
      message
    end

    private

    def date_time_message
      "⏰ Дата і час: #{resource.start_at.strftime('%Y-%m-%d')} #{resource.end_at&.strftime('| %Y-%m-%d')} \n"
    end

    def link_message
      "[Посилання на турнір](#{ENV['BASE_FRONT_URL']}/calendar/tournament/#{resource.id}/main) \n"
    end

  end
end

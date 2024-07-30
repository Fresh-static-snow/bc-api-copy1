# frozen_string_literal: true

module BotsNotification
  class MatchNotifiable < BotsNotification::Notifiable

    attr_reader :tournament, :match_casts, :user_intance

    def initialize(resource, action_name)
      super(resource, action_name)

      @tournament = resource.tournament
      @match_casts = resource.match_casts
    end

    def message_text # rubocop:disable Metrics/AbcSize
      message = "#{action_icon} Турнір: #{tournament.title} \n"
      message += match_title
      message += date_time_message_part
      message += "🎨 Формат: BO#{resource.best_of} \n"
      message += link_message
      message += "---------------- Casts ------------- \n" if match_casts

      match_casts.each do |match_cast|
        message += "🇺🇦 Мова трансляції: #{match_cast.language.name} \n"
        message += "🎤 Коментатори: #{match_cast.commentators.pluck(:display_name).join(' ')} \n"
        message += "🏋️‍♀️ Бекап Коментатори: #{match_cast.backup_commentators.pluck(:display_name).join(' ')} \n"
        message += "🗣 Аналітики: #{match_cast.analytics.pluck(:display_name).join(' ')} \n"
        message += "🧘‍♂️ Хост Аналітик: #{match_cast.host_analytic&.display_name} \n"
        message += "👥 Стафф: #{match_cast.staff_members.pluck(:display_name).join(' ')} \n"
        message += "🎪 Студія: #{match_cast.studio&.name} \n"
        message += "♟ Студія аналітики: #{match_cast.analytic_studio&.name} \n"
        message += "🎛 Сетап: #{match_cast.setup&.name} \n"
        message += "🎛 Стрім: #{match_cast.stream&.name} \n"
        message += "📢 Канали: #{channels_join(match_cast.channels.pluck(:name))} \n"
        message += "------------------------ \n"
      end
      message
    end

    private

    def language_or_staff_display?
      !user_intance&.try('commentator?') || !user_intance.try('analytic?')
    end

    def comm_display?
      !user_intance.try('analytic?')
    end

    def analytic_display?
      !user_intance&.try('commentator?')
    end

    def date_time_message_part
      "⏰ Дата і час: #{resource.start_at.strftime('%Y-%m-%d | %H:%M')}#{resource.end_at&.strftime(' - %H:%M')} \n"
    end

    def link_message
      "[Посилання на матч](#{ENV['BASE_FRONT_URL']}/calendar/day?start_at=#{resource.start_at.strftime('%Y-%m-%d')}&current_user=true) \n" # rubocop:disable Layout/LineLength
    end

    def match_title
      if resource.type == 'Match'
        "💥 Матч: #{resource.team_one&.name || ''} 🆚 #{resource.team_two&.name || ''} \n"
      else
        "💥 Сегмент: #{resource.title || ''} \n"
      end
    end

  end
end

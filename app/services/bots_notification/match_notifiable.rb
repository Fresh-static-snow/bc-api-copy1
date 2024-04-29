# frozen_string_literal: true

module BotsNotification
  class MatchNotifiable < BotsNotification::Notifiable

    attr_reader :tournament, :match_casts, :user_intance

    def initialize(resource, user, action_name)
      super(resource, user.user, action_name)

      @user_intance = user
      @tournament = resource.tournament
      @match_casts = resource.match_casts
    end

    private

    def message_text # rubocop:disable Metrics/AbcSize
      message = "#{action_icon} Турнір: #{tournament.title} \n"
      message += "💥 Матч: #{resource.team_one&.name || ''} 🆚 #{resource.team_two&.name || ''} \n"
      message += date_time_message_part
      message += "🎨 Формат: BO#{resource.best_of} \n"
      message += link_message
      message += "---------------- Casts ------------- \n" if match_casts

      match_casts.each do |match_cast|
        message += "🇺🇦 Мова трансляції: #{match_cast.language.name} \n" if language_or_staff_display?
        message += "🎤 Коментатори: #{match_cast.commentators.pluck(:display_name).join(' ')} \n"
        message += "🎤 Бекап ком.: #{match_cast.backup_commentator&.display_name} \n"
        message += "🗣 Аналітики: #{match_cast.analytics.pluck(:display_name).join(' ')} \n"
        message += "🗣 Хост Аналітик: #{match_cast.host_analytic&.display_name} \n"
        message += "👥 Стафф: #{match_cast.staff_members.pluck(:display_name).join(' ')} \n"
        message += "🎪 Студія: #{match_cast.studio&.name} \n"
        message += "♟ Студія аналітики: #{match_cast.analytic_studio&.name} \n" if language_or_staff_display?
        message += "📢 Канали: #{channels_join(match_cast.channels.pluck(:name))} \n"
        message += "------------------------ \n"
      end
      message
    end

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

  end
end

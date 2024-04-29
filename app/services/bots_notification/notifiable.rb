# frozen_string_literal: true

module BotsNotification
  class Notifiable

    attr_reader :resource, :user, :tournament, :action_name, :match_casts

    def initialize(resource, user, action_name)
      @resource = resource
      @user = user
      @action_name = action_name
    end

    def perform # rubocop:disable Metrics/AbcSize
      if user.telegram_chat_id
        telegram_client.send_message(chat_id: user.telegram_chat_id, text: message_text,
                                     parse_mode: :Markdown)
      end

      discord_client.user(user.discord_user_id).pm(message_text) if user.discord_user_id
    end

    private

    def telegram_client
      Telegram.bots[:chat]
    end

    def discord_client
      Discordrb::Bot.new token: ENV['DISCORD_TOKEN']
    end

    def action_icon
      action_name == :update ? '⚠️' : '✅'
    end

    def channels_join(array)
      array.join(' | ').gsub(/_/, '\_')
    end

  end
end

# frozen_string_literal: true

module BotsNotification
  class Notifiable

    attr_reader :resource, :tournament, :action_name, :match_casts

    def initialize(resource, action_name)
      @resource = resource
      @action_name = action_name
    end

    class << self

      def telegram_client
        Telegram.bots[:chat]
      end

      def discord_client
        Discordrb::Bot.new token: ENV['DISCORD_TOKEN']
      end

    end

    private

    def action_icon
      action_name == :update ? '⚠️' : '✅'
    end

    def channels_join(array)
      array.join(' | ').gsub(/_/, '\_')
    end

  end
end

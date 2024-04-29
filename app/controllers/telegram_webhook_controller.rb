# frozen_string_literal: true

class TelegramWebhookController < Telegram::Bot::UpdatesController

  def start!(*)
    link = "Для привязки аккаунта перейдіть за [_Посиланням_](#{ENV['BASE_FRONT_URL']}/telegram/#{from['id']}/)"

    respond_with :message, text: link, parse_mode: :MarkdownV2
  end

end

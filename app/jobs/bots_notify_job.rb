# frozen_string_literal: true

class BotsNotifyJob < ApplicationJob

  queue_as :default

  def perform(users, resource, message_text, _action_name)
    telegram_client = BotsNotification::Notifiable.telegram_client
    discord_client  = BotsNotification::Notifiable.discord_client

    users.uniq(&:id).each do |user|
      next unless notifiable_rules(resource, user)

      if user.telegram_chat_id
        telegram_client.send_message(
          chat_id: user.telegram_chat_id,
          text: message_text,
          parse_mode: :Markdown
        )
      end

      discord_client.user(user.discord_user_id).pm(message_text) if user.discord_user_id
    end
  end

  private

  def notifiable_rules(resource, user)
    return true if resource.is_a?(Tournament)

    resource.reload.visible && resource.tournament.reload.visible ||
      User.with_permission(:create_entity).exists?(user.id)
  end

end

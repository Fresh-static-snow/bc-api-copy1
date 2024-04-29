# frozen_string_literal: true

class NotifyDashboardChannel < ApplicationCable::Channel

  def subscribed
    stream_for current_user
  end

  def send_message(data)
    broadcast_to current_user, data
  end

end

# frozen_string_literal: true

class GoogleDriveJob < ApplicationJob

  queue_as :default
  sidekiq_options retry: 3, retry_in: 1.hour, concurrency: 1

  def perform
    GoogleApi::SheetV4::DeleteFolder.call
  end

end

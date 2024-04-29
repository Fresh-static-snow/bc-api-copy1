# frozen_string_literal: true

class FetchApiToolsDataJob < ApplicationJob

  queue_as :default

  def perform
    ApiTools::Tournaments.new.fetch_data
  end

end

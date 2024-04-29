# frozen_string_literal: true

class ApplicationController < ActionController::API

  include Auth
  include ExceptionHandler
  include ApplicationHelper

  before_action :set_default_user_params

  private

  def set_default_user_params
    Time.zone = current_user&.try(:time_zone) || ENV.fetch('APP_TIMEZONE', 'Europe/Kiev')

    I18n.locale = params[:locale]
  rescue I18n::InvalidLocale
    I18n.locale = I18n.default_locale
  end

  def handle_entity_result(result, status)
    if result.errors.any?
      render_json_response(false, result.errors.full_messages, :unprocessable_entity)
    else
      render_json_response(true, result, status)
    end
  end

end

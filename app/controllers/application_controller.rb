# frozen_string_literal: true

class ApplicationController < ActionController::API

  include Auth
  include ExceptionHandler
  include ApplicationHelper

  before_action :set_default_user_params
  before_action :set_sentry_context

  private

  def set_default_user_params
    Time.zone = current_user&.try(:time_zone) || ENV.fetch('APP_TIMEZONE', 'Europe/Kiev')

    I18n.locale = params[:locale]
  rescue I18n::InvalidLocale
    Sentry.set_extras(stats: params[:locale]) do
      Sentry.capture_exception(e)
    end

    I18n.locale = I18n.default_locale
  end

  def handle_entity_result(result, status)
    if result.errors.any?
      render_json_response(false, result.errors.full_messages, :unprocessable_entity)
    else
      render_json_response(true, result, status)
    end
  end

  def set_sentry_context
    if user_signed_in?
      Sentry.set_user(
        nickname: current_user.display_name,
        id: current_user.id
      )
    end

    # TODO: need to add company tanency param
    Sentry.set_extras(
      params: params.to_unsafe_h,
      url: request.url
    )
  end

end

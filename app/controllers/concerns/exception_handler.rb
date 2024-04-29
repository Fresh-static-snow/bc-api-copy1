# frozen_string_literal: true

module ExceptionHandler

  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, ArgumentError, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound,               with: :record_not_found
    rescue_from ActionController::ParameterMissing,         with: :unprocessable_entity

    rescue_from Pundit::NotAuthorizedError, with: :not_permitted
  end

  private

  def unprocessable_entity(error)
    render_json_response(false, error.message.full_messages, :unprocessable_entity) if Rails.env.production?
  end

  def record_not_found(exception)
    render_json_response(false, "Record not found: #{exception.model} with ID=#{exception.id}", :not_found)
  end

  def unauthorized_request(error)
    render_json_response(false, error.message.full_messages, :unauthorized)
  end

  def not_permitted
    render_json_response(false, 'Not permitted action', :forbidden)
  end

end

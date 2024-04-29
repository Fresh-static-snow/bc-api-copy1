# frozen_string_literal: true

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Action Controller caching (Doesn't work for API applications)
  config.action_controller.perform_caching = false

  config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local
  config.active_storage.variant_processor = :mini_magick
  config.active_storage.content_types_to_serve_as_binary.delete('image/svg+xml')

  # config.action_mailer.perform_caching = false
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.perform_deliveries = true
  # config.action_mailer.default :charset => "utf-8"
  
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {
    :address => ENV.fetch('SMTP_HOST', '127.0.0.1'),
    :port => ENV.fetch('SMTP_PORT', '1025')
  }

  config.active_job.queue_adapter = :sidekiq

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'ws://localhost:3000/cable'
  # config.action_cable.allowed_request_origins = [/http:\/\/*/, /https:\/\/*/]

end

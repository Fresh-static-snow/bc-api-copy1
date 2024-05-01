# frozen_string_literal: true

require_relative 'boot'
require_relative '../lib/middleware/sanitizer'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'rails/test_unit/railtie'
require 'dotenv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BroadcastShiftCalendar
  class Application < Rails::Application
    Dotenv.load if Rails.env.development? || Rails.env.test?
    Dotenv.load('.env.staging') if Rails.env.staging?
    Dotenv.load('.env.production') if Rails.env.production?

    # configs from environment variables
    # config.broadcast_shift_calendar_api = config_for(:broadcast_shift_calendar_api)

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # This also configures session_options for use below
    config.session_store :cookie_store, key: '_broadcast-shift-calendar-session'

    # Required for all session management (regardless of session_store)
    config.middleware.use ActionDispatch::Cookies

    config.middleware.use config.session_store, config.session_options

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins(
          'http://localhost:3000',
          'http://localhost:9000',
          'https://broadcast-shift-calendar-dev.netlify.app',
          'https://crm.maincast.com',
          'https://next-crm.maincast.com',
          'https://demo-crm.maincast.com'
        )

        resource(
          '*',
          headers: :any,
          expose: ["Authorization"],
          methods: [:get, :patch, :put, :delete, :post, :options, :show],
          credentials: true
        )
      end
    end

    config.middleware.use Rack::InputParamsSanitizer

    # Mount Action Cable outside main process or domain.root_api_url
    config.action_cable.url = ENV.fetch('ACTION_CABLE_URL', 'ws://localhost:3000/cable')
    config.action_cable.allowed_request_origins = [
      /http:\/\/localhost:3000\/*/,
      /http:\/\/localhost:9000\/*/,
      /https:\/\/broadcast-shift-calendar-dev.netlify.app\/*/,
      /https:\/\/crm.maincast.com\/*/,
      /https:\/\/next-crm.maincast.com\/*/,
      /https:\/\/demo-crm.maincast.com\/*/,
      /https:\/\/192.168.65.1\/*/
    ]

    config.base_front_url = ENV.fetch('BASE_FRONT_URL', 'http://localhost:9000')
  end
end

Rails.application.routes.default_url_options[:host] = ENV.fetch('ROOT_API_URL', 'http://localhost:3000')

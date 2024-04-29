# frozen_string_literal: true

require 'rails-html-sanitizer'

module Rack
  class InputParamsSanitizer

    ALLOWED_TAGS = %w[p strong ol li ul u br s h1 h2 h3 h4 a].freeze

    def initialize(app)
      @app = app
      @safe_list_sanitizer = Rails::Html::Sanitizer.safe_list_sanitizer.new
    end

    def call(env)
      req = Rack::Request.new(env)
      sanitize_params(env, req) unless req.form_data?

      app.call(env)
    end

    private

    attr_reader :app, :safe_list_sanitizer

    def sanitize_params(env, req)
      clean_params = strip_all(fetch_params(env, req)).deep_transform_values do |v|
        v.is_a?(String) ? CGI.unescape_html(v) : v
      end
      env["rack.input"] = if req.get?
                            StringIO.new(Rack::Utils.build_query(clean_params))
                          else
                            StringIO.new(JSON.generate(clean_params))
                          end
    end

    def fetch_params(env, req)
      return Rack::Utils.parse_query(env['rack.input'].read, "&") if req.get?

      request_body = req.body.read
      request_body.present? ? JSON.parse(request_body) : {}
    end

    def strip(value)
      if value.is_a?(Hash)
        value.transform_values { |v| strip(v) }
      elsif value.is_a?(Array)
        value.map(&method(:strip))
      elsif value.is_a?(String)
        safe_list_sanitizer.sanitize(value, tags: ALLOWED_TAGS)
      else
        value
      end
    end

    def strip_all(params)
      params.map { |key, value| [strip(key), strip(value)] }.to_h
    end

  end
end

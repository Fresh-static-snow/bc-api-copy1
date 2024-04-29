# frozen_string_literal: true

require 'rails_helper'
require 'rswag/api'
require 'rswag/specs'

url = case ENV['RAILS_ENV']
      when 'production'
        'https://api-crm.maincast.com'
      when 'staging'
        'https://next-api-crm.maincast.com'
      else
        'http://localhost:3000'
      end

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: url
        }
      ]
    }
  }

  config.before(:each, type: :request) do
    include Rswag::Specs::ExampleGroups
  end
end

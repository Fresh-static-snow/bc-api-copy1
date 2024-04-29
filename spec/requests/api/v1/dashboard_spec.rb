# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Api::V1::Search', type: :request do
  path '/api/v1/dashboard/counts' do
    get 'Get entity counts list' do
      tags 'Dashboard'
      produces 'application/json'

      response '200', 'entity counts list' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'error' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: false
                 },
                 "errors": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
  path '/api/v1/dashboard/users' do
    get 'Get users roles list' do
      tags 'Dashboard'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string

      response '200', 'users roles list' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'error' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: false
                 },
                 "errors": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
  path '/api/v1/dashboard/companies' do
    get 'Get companies list' do
      tags 'Dashboard'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string

      response '200', 'sponsors list' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'error' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: false
                 },
                 "errors": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
  path '/api/v1/dashboard/notifications' do
    get 'Get notifications list' do
      tags 'Dashboard'
      produces 'application/json'

      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false
      parameter name: :start_id, in: :query, type: :integer, required: false

      response '200', 'notifications list' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'error' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: false
                 },
                 "errors": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end

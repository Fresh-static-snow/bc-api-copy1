# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

module AuthApiDocs

  LOGIN_PARAMS = {
    type: :object,
    properties: {
      "user[email]": { type: :string },
      "user[password]": { type: :string }
    },
    required: %i[email password]
  }.freeze

  RESET_PARAMS = {
    type: :object,
    properties: {
      "user[email]": { type: :string }
    },
    required: %i[email]
  }.freeze

  RESET_PASS_PARAMS = {
    type: :object,
    properties: {
      "user[reset_password_token]": { type: :string },
      "user[password]": { type: :string },
      "user[password_confirmation]": { type: :string }
    },
    required: %i[reset_password_token password password_confirmation]
  }.freeze

  INVITATION_PARAMS = {
    type: :object,
    properties: {
      "user[invitation_token]": { type: :string },
      "user[password]": { type: :string },
      "user[password_confirmation]": { type: :string }
    },
    required: %i[invitation_token password password_confirmation]
  }.freeze

  SUCCESS_RESPONSE = {
    type: :object,
    properties: {
      success: { type: :boolean, default: true },
      data: { type: :object }
    }
  }.freeze

  ERROR_RESPONSE = {
    type: :object,
    properties: {
      success: { type: :boolean, default: false },
      errors: { type: :object }
    }
  }.freeze

end

RSpec.describe 'Api::V1::Auth', type: :request do
  path '/api/v1/login' do
    post 'Sign In' do
      tags 'Auth'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :user, in: :formData, schema: AuthApiDocs::LOGIN_PARAMS

      response '201', 'User sign in' do
        schema AuthApiDocs::SUCCESS_RESPONSE

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'user login error' do
        schema AuthApiDocs::ERROR_RESPONSE

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  path '/api/v1/logout' do
    delete 'Sign Out' do
      tags 'Auth'
      consumes 'multipart/form-data'
      produces 'application/json'

      response '200', 'user sign out' do
        schema AuthApiDocs::SUCCESS_RESPONSE

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'game_discipline error' do
        schema AuthApiDocs::ERROR_RESPONSE

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  path '/api/v1/invitation' do
    put 'Accept Invitation' do
      tags 'Auth'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :user, in: :formData, schema: AuthApiDocs::INVITATION_PARAMS

      response '200', 'invitation accepted' do
        schema AuthApiDocs::SUCCESS_RESPONSE

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'invitation error' do
        schema AuthApiDocs::ERROR_RESPONSE

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  path '/api/v1/password' do
    post 'Send Reset Password Link' do
      tags 'Auth'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :user, in: :formData, schema: AuthApiDocs::RESET_PARAMS

      response '200', 'password reset link sent' do
        schema AuthApiDocs::SUCCESS_RESPONSE

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'password reset link error' do
        schema AuthApiDocs::ERROR_RESPONSE

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    put 'Reset Password' do
      tags 'Auth'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :user, in: :formData, schema: AuthApiDocs::RESET_PASS_PARAMS

      response '200', 'password reset ok' do
        schema AuthApiDocs::SUCCESS_RESPONSE

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'password reset error' do
        schema AuthApiDocs::ERROR_RESPONSE

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end

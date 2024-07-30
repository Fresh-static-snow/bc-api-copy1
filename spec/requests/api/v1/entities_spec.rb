# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Api::V1::Entities', type: :request do
  path '/api/v1/account_setting' do
    get 'Get account setting' do
      tags 'Account Setting'
      consumes 'multipart/form-data'
      produces 'application/json'

      response '200', 'user soft destroy' do
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

      response '422', 'user soft delete' do
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
  path '/api/v1/account_setting' do
    put 'Get account setting' do
      tags 'Account Setting'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :current_user_filter_enabled, in: :formData, type: :boolean
      parameter name: :default_calendar_scope, in: :formData, type: :string

      response '200', 'user soft destroy' do
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

      response '422', 'user soft delete' do
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
  path '/api/v1/calendar' do
    get 'Get entities list' do
      tags 'Calendar'
      produces 'application/json'

      parameter name: :period_from, in: :query, type: :string, format: "date-time"
      parameter name: :period_to, in: :query, type: :string, format: "date-time"
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[day week month quarter year]
      }
      parameter name: :game_discipline, in: :query, type: :array
      parameter name: :studio, in: :query, type: :array
      parameter name: :analytic_studio, in: :query, type: :array
      parameter name: :setup, in: :query, type: :array
      parameter name: :stream, in: :query, type: :array
      parameter name: :channel, in: :query, type: :array
      parameter name: :managers, in: :query, type: :array
      parameter name: :main_participants, in: :query, type: :array
      parameter name: :media_representatives, in: :query, type: :array
      parameter name: :staff_members, in: :query, type: :array
      parameter name: :analytics, in: :query, type: :array
      parameter name: :commentators, in: :query, type: :array
      parameter name: :current_user, in: :query, type: :array

      response '200', 'entities list' do
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

      response '422', 'entities error' do
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
  path '/api/v1/calendar/filters' do
    get 'Get filters list' do
      tags 'Calendar'
      produces 'application/json'

      response '200', 'filters list' do
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

      response '422', 'filters error' do
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

  path '/api/v1/game_disciplines' do
    get 'Get game_disciplines list' do
      tags 'Game Discipline'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }

      response '200', 'game_disciplines list' do
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
    post 'Creates game_discipline' do
      tags 'Game Discipline'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "title": { type: :string },
          "keyword": { type: :string },
          "cover": { type: :file }
        },
        required: %i[title cover]
      }

      response '201', 'game_discipline created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'game_discipline error' do
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
  path '/api/v1/game_disciplines/{id}' do
    get 'Show game_discipline' do
      tags 'Game Discipline'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show game_discipline' do
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
    end
    put 'Update game_discipline' do
      tags 'Game Discipline'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "title": { type: :string },
          "keyword": { type: :string },
          "cover": { type: :file }
        },
        required: %i[title cover]
      }

      response '200', 'game_discipline updated' do
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

      response '422', 'game_discipline error' do
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
    delete 'Delete game_discipline' do
      tags 'Game Discipline'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'game_discipline deleted' do
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

      response '422', 'game_discipline error' do
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
  path '/api/v1/game_disciplines/{id}/soft_destroy' do
    delete 'Soft destroy game_discipline' do
      tags 'Game Discipline'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'game_discipline deleted' do
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

      response '422', 'game_discipline error' do
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
  path '/api/v1/game_disciplines/{id}/restore' do
    put 'Restore deleted game discipline' do
      tags 'Game Discipline'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'restore game discipline' do
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

      response '422', 'restore game discipline' do
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
  path '/api/v1/game_disciplines/{id}/edit' do
    get 'Edit game_discipline' do
      tags 'Game Discipline'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit game_discipline' do
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
    end
  end

  path '/api/v1/tournaments' do
    get 'Get tournaments list' do
      tags 'Tournament'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }
      parameter name: :year, in: :query, type: :integer

      response '200', 'tournaments list' do
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
    post 'Creates tournament' do
      tags 'Tournament'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "game_discipline_id": { type: :integer },
          "title": { type: :integer },
          "start_at": { type: :integer },
          "end_at": { type: :integer },
          "region_id": { type: :integer },
          "type_id": { type: :integer },
          "owner_id": { type: :integer },
          "visible": { type: :boolean, enum: %w[true false] },
          "top": { type: :integer, minimum: 1, maximum: 3, enum: (1..3).to_a },
          "main_participant_ids": { type: :array },
          "media_representative_ids": { type: :array },
          "sponsor_ids": { type: :array },
          "sponsors_attributes[name]": { type: :array },
          "descriptions_attributes[title]": { type: :array },
          "descriptions_attributes[description]": { type: :array },
          "media_attributes[title]": { type: :array },
          "media_attributes[description]": { type: :array },
          "cover": { type: :file }
        },
        required: %i[title game_discipline_id start_at]
      }

      response '201', 'tournament created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'tournament error' do
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
  path '/api/v1/tournaments/{id}' do
    get 'Show tournament' do
      tags 'Tournament'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show tournament' do
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
    end
    put 'Update tournament' do
      tags 'Tournament'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "game_discipline_id": { type: :integer },
          "title": { type: :integer },
          "start_at": { type: :integer },
          "end_at": { type: :integer },
          "region_id": { type: :integer },
          "type_id": { type: :integer },
          "owner_id": { type: :integer },
          "visible": { type: :boolean, enum: %w[true false] },
          "top": { type: :integer, minimum: 1, maximum: 3, enum: (1..3).to_a },
          "main_participant_ids": { type: :array },
          "media_representative_ids": { type: :array },
          "sponsor_ids": { type: :array },
          "descriptions_attributes[id]": { type: :array },
          "descriptions_attributes[title]": { type: :array },
          "descriptions_attributes[description]": { type: :array },
          "media_attributes[id]": { type: :array },
          "media_attributes[title]": { type: :array },
          "media_attributes[description]": { type: :array },
          "cover": { type: :file }
        },
        required: %i[title game_discipline_id start_at]
      }

      response '200', 'tournament updated' do
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

      response '422', 'tournament error' do
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
    delete 'Delete tournament' do
      tags 'Tournament'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'tournament created' do
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

      response '422', 'tournament error' do
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
  path '/api/v1/tournaments/{id}/soft_destroy' do
    delete 'Delete tournament' do
      tags 'Tournament'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'tournament created' do
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

      response '422', 'tournament error' do
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
  path '/api/v1/tournaments/{id}/restore' do
    put 'Restore deleted tournament' do
      tags 'Tournament'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'restore tournament' do
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

      response '422', 'restore tournament' do
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
  path '/api/v1/tournaments/{id}/edit' do
    get 'Edit tournament' do
      tags 'Tournament'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit tournament' do
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
    end
  end
  path '/api/v1/tournaments/{id}/media' do
    get 'Show tournament media' do
      tags 'Tournament'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show tournament media' do
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
    end
  end
  path '/api/v1/tournaments/{id}/schedule' do
    get 'Show tournament schedule' do
      tags 'Tournament'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show tournament schedule matches' do
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
    end
  end
  path '/api/v1/tournaments/{id}/comments' do
    get 'Show tournament comments' do
      tags 'Tournament'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show tournament comments' do
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
    end
  end
  path '/api/v1/tournaments/types' do
    get 'Get tournaments types list' do
      tags 'Tournament'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string

      response '200', 'tournaments types list' do
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

  path '/api/v1/matches' do
    post 'Creates match' do
      tags 'Match'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "tournament_id": { type: :integer },
          "start_at": { type: :string, format: "date-time" },
          "end_at": { type: :string, format: "date-time" },
          "best_of": { type: :integer },
          "team_one_id": { type: :integer },
          "team_two_id": { type: :integer },
          "visible": { type: :boolean, enum: %w[true false] },
          "match_casts_attributes[cast_language_id]": { type: :integer },
          "match_casts_attributes[cast_studio_id]": { type: :integer },
          "match_casts_attributes[cast_analytic_studio_id]": { type: :integer },
          "match_casts_attributes[cast_setup_id]": { type: :integer },
          "match_casts_attributes[cast_stream_id]": { type: :integer },
          "match_casts_attributes[cast_channel_id]": { type: :integer },
          "match_casts_attributes[analytic_ids]": { type: :array },
          "match_casts_attributes[commentator_ids]": { type: :array },
          "match_casts_attributes[staff_member_ids]": { type: :array }
        },
        required: %i[tournament_id start_at best_of team_one_id team_two_id]
      }
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }

      response '201', 'match created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'match error' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: false
                 },
                 "errors": {
                   type: :object
                 }
               },
               required: []

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
  path '/api/v1/matches' do
    get 'Show matches' do
      tags 'Match'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }

      response '200', 'show match' do
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
    end
  end
  path '/api/v1/matches/{id}' do
    get 'Show match' do
      tags 'Match'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show match' do
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
    end
    put 'Update match' do
      tags 'Match'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "tournament_id": { type: :integer },
          "start_at": { type: :string, format: "date-time" },
          "end_at": { type: :string, format: "date-time" },
          "best_of": { type: :integer },
          "team_one_id": { type: :integer },
          "team_two_id": { type: :integer },
          "visible": { type: :boolean, enum: %w[true false] },
          "match_cast_ids": { type: :array },
          "match_casts_attributes[cast_language_id]": { type: :integer },
          "match_casts_attributes[cast_studio_id]": { type: :integer },
          "match_casts_attributes[cast_analytic_studio_id]": { type: :integer },
          "match_casts_attributes[cast_channel_id]": { type: :integer },
          "match_casts_attributes[analytic_ids]": { type: :array },
          "match_casts_attributes[commentator_ids]": { type: :array },
          "match_casts_attributes[staff_member_ids]": { type: :array }
        },
        required: %i[tournament_id start_at best_of team_one_id team_two_id]
      }

      response '200', 'match created' do
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

      response '422', 'match error' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: false
                 },
                 "errors": {
                   type: :object
                 }
               },
               required: []

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    delete 'Delete match' do
      tags 'Match'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'match created' do
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

      response '422', 'match error' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: false
                 },
                 "errors": {
                   type: :object
                 }
               },
               required: []

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
  path '/api/v1/matches/destroy' do
    delete 'Destroy matches' do
      tags 'Match'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :ids, in: :query, type: :array

      response '200', 'matches destroyed' do
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

      response '422', 'matches error' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: false
                 },
                 "errors": {
                   type: :object
                 }
               },
               required: []

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
  path '/api/v1/matches/soft_destroy' do
    delete 'Soft destroy matches' do
      tags 'Match'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :ids, in: :query, type: :array

      response '200', 'matches created' do
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

      response '422', 'matches error' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: false
                 },
                 "errors": {
                   type: :object
                 }
               },
               required: []

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
  path '/api/v1/matches/restore' do
    put 'Restore deleted matches' do
      tags 'Match'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :ids, in: :query, type: :array

      response '200', 'restore matches' do
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

      response '422', 'restore matches' do
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

  path '/api/v1/matches/{id}/soft_destroy' do
    delete 'Soft destroy match' do
      tags 'Match'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'match destroyed' do
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

      response '422', 'match error' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: false
                 },
                 "errors": {
                   type: :object
                 }
               },
               required: []

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  path '/api/v1/matches/{id}/restore' do
    put 'Restore deleted match' do
      tags 'Match'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'restore match' do
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

      response '422', 'restore match' do
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
  path '/api/v1/matches/{id}/edit' do
    get 'Edit match' do
      tags 'Match'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit match' do
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
    end
  end
  path '/api/v1/matches/types' do
    get 'Get list entities' do
      tags 'Match'
      produces 'application/json'

      response '200', 'Match types list' do
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
    end
  end

  path '/api/v1/casts/languages' do
    get 'Get casts languages list' do
      tags 'Cast Language'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }
      parameter name: :with_history, in: :query, type: :boolean, default: false

      response '200', 'casts languages list' do
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
    post 'Creates cast languages' do
      tags 'Cast Language'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string },
          "keyword": { type: :string }
        },
        required: %i[name]
      }

      response '201', 'cast language created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'cast language error' do
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
  path '/api/v1/casts/languages/{id}' do
    get 'Show cast language' do
      tags 'Cast Language'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show cast language' do
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
    end
    put 'Update cast language' do
      tags 'Cast Language'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string },
          "keyword": { type: :string }
        },
        required: %i[name]
      }

      response '200', 'cast language updated' do
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

      response '422', 'cast language error' do
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
    delete 'Delete cast language' do
      tags 'Cast Language'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'cast language created' do
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

      response '422', 'cast language error' do
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
  path '/api/v1/casts/languages/{id}/soft_destroy' do
    delete 'Soft destroy language' do
      tags 'Cast Language'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'language deleted' do
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

      response '422', 'language error' do
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
  path '/api/v1/casts/languages/{id}/restore' do
    put 'Restore deleted language' do
      tags 'Cast Language'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'language restore' do
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

      response '422', 'restore language' do
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
  path '/api/v1/casts/languages/{id}/edit' do
    get 'Edit cast language' do
      tags 'Cast Language'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit cast language' do
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
    end
  end

  path '/api/v1/casts/analytic_studios' do
    get 'Get casts analytic_studios list' do
      tags 'Cast Analytic Studio'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }
      parameter name: :with_history, in: :query, type: :boolean, default: false

      response '200', 'casts analytic_studios list' do
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
    post 'Creates cast analytic_studios' do
      tags 'Cast Analytic Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string },
          "keyword": { type: :string }
        },
        required: %i[name]
      }

      response '201', 'Cast Analytic Studio created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'Cast Analytic Studio error' do
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
  path '/api/v1/casts/analytic_studios/{id}' do
    get 'Show Cast Analytic Studio' do
      tags 'Cast Analytic Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show Cast Analytic Studio' do
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
    end
    put 'Update Cast Analytic Studio' do
      tags 'Cast Analytic Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string },
          "keyword": { type: :string }
        },
        required: %i[name]
      }

      response '200', 'Cast Analytic Studio updated' do
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

      response '422', 'Cast Analytic Studio error' do
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
    delete 'Delete Cast Analytic Studio' do
      tags 'Cast Analytic Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'Cast Analytic Studio created' do
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

      response '422', 'Cast Analytic Studio error' do
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
  path '/api/v1/casts/analytic_studios/{id}/soft_destroy' do
    delete 'Soft destroy analytic studio' do
      tags 'Cast Analytic Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'analytic studio deleted' do
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

      response '422', 'analytic studio error' do
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
  path '/api/v1/casts/analytic_studios/{id}/restore' do
    put 'Restore deleted analytic studio' do
      tags 'Cast Analytic Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'restore analytic studio' do
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

      response '422', 'restore game discipline' do
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
  path '/api/v1/casts/analytic_studios/{id}/edit' do
    get 'Edit Cast Analytic Studio' do
      tags 'Cast Analytic Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit Cast Analytic Studio' do
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
    end
  end

  path '/api/v1/casts/studios' do
    get 'Get casts studios list' do
      tags 'Cast Studio'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }
      parameter name: :with_history, in: :query, type: :boolean, default: false

      response '200', 'casts studios list' do
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
    post 'Creates cast studios' do
      tags 'Cast Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string },
          "keyword": { type: :string }
        },
        required: %i[name]
      }

      response '201', 'cast studio created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'cast studio error' do
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
  path '/api/v1/casts/studios/{id}' do
    get 'Show cast studio' do
      tags 'Cast Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show cast studio' do
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
    end
    put 'Update cast studio' do
      tags 'Cast Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string },
          "keyword": { type: :string }
        },
        required: %i[name]
      }

      response '200', 'cast studio updated' do
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

      response '422', 'cast studio error' do
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
    delete 'Delete cast studio' do
      tags 'Cast Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'cast studio created' do
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

      response '422', 'cast studio error' do
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
  path '/api/v1/casts/studios/{id}/soft_destroy' do
    delete 'Soft destroy studio' do
      tags 'Cast Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'studio soft deleted' do
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

      response '422', 'studio error' do
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
  path '/api/v1/casts/studios/{id}/restore' do
    put 'Restore deleted studio' do
      tags 'Cast Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'restore studio' do
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

      response '422', 'restore studio' do
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
  path '/api/v1/casts/studios/{id}/edit' do
    get 'Edit cast studio' do
      tags 'Cast Studio'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit cast studio' do
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
    end
  end

  path '/api/v1/casts/setups' do
    get 'Get casts setups list' do
      tags 'Cast Setup'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }
      parameter name: :with_history, in: :query, type: :boolean, default: false

      response '200', 'casts setups list' do
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
    post 'Creates cast setups' do
      tags 'Cast Setup'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string }
        },
        required: %i[name]
      }

      response '201', 'cast setup created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'cast setup error' do
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
  path '/api/v1/casts/setups/{id}' do
    get 'Show cast setup' do
      tags 'Cast Setup'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show cast setup' do
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
    end
    put 'Update cast setup' do
      tags 'Cast Setup'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string }
        },
        required: %i[name]
      }

      response '200', 'cast setup updated' do
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

      response '422', 'cast setup error' do
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
    delete 'Delete cast setup' do
      tags 'Cast Setup'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'cast setup created' do
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

      response '422', 'cast setup error' do
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
  path '/api/v1/casts/setups/{id}/soft_destroy' do
    delete 'Soft destroy setup' do
      tags 'Cast Setup'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'setup soft deleted' do
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

      response '422', 'setup error' do
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
  path '/api/v1/casts/setups/{id}/restore' do
    put 'Restore deleted setup' do
      tags 'Cast Setup'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'restore setup' do
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

      response '422', 'restore setup' do
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
  path '/api/v1/casts/setups/{id}/edit' do
    get 'Edit cast setup' do
      tags 'Cast Setup'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit cast setup' do
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
    end
  end

  path '/api/v1/casts/streams' do
    get 'Get casts streams list' do
      tags 'Cast Stream'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }
      parameter name: :with_history, in: :query, type: :boolean, default: false

      response '200', 'casts streams list' do
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
    post 'Creates cast streams' do
      tags 'Cast Stream'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string }
        },
        required: %i[name]
      }

      response '201', 'cast stream created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'cast stream error' do
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
  path '/api/v1/casts/streams/{id}' do
    get 'Show cast stream' do
      tags 'Cast Stream'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show cast stream' do
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
    end
    put 'Update cast stream' do
      tags 'Cast Stream'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string }
        },
        required: %i[name]
      }

      response '200', 'cast stream updated' do
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

      response '422', 'cast stream error' do
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
    delete 'Delete cast stream' do
      tags 'Cast Stream'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'cast stream created' do
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

      response '422', 'cast stream error' do
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
  path '/api/v1/casts/streams/{id}/soft_destroy' do
    delete 'Soft destroy stream' do
      tags 'Cast Stream'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'stream soft deleted' do
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

      response '422', 'stream error' do
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
  path '/api/v1/casts/streams/{id}/restore' do
    put 'Restore deleted stream' do
      tags 'Cast Setup'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'restore stream' do
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

      response '422', 'restore stream' do
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
  path '/api/v1/casts/streams/{id}/edit' do
    get 'Edit cast stream' do
      tags 'Cast Setup'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit cast stream' do
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
    end
  end

  path '/api/v1/casts/channels' do
    get 'Get casts channels list' do
      tags 'Cast Channel'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }
      parameter name: :with_history, in: :query, type: :boolean, default: false

      response '200', 'casts channels list' do
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
    post 'Creates cast channels' do
      tags 'Cast Channel'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string }
        },
        required: %i[name]
      }

      response '201', 'cast channel created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'cast channel error' do
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
  path '/api/v1/casts/channels/{id}' do
    get 'Show cast channel' do
      tags 'Cast Channel'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show cast channel' do
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
    end
    put 'Update cast channel' do
      tags 'Cast Channel'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string }
        },
        required: %i[name]
      }

      response '200', 'cast channel updated' do
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

      response '422', 'cast channel error' do
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
    delete 'Delete cast channel' do
      tags 'Cast Channel'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'cast channel created' do
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

      response '422', 'cast channel error' do
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
  path '/api/v1/casts/channels/{id}/soft_destroy' do
    delete 'Soft destroy channel' do
      tags 'Cast Channel'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'channel deleted' do
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

      response '422', 'channel error' do
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
  path '/api/v1/casts/channels/{id}/restore' do
    put 'Restore deleted channel' do
      tags 'Cast Channel'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'restore channel' do
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

      response '422', 'restore channel' do
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
  path '/api/v1/casts/channels/{id}/edit' do
    get 'Edit cast channel' do
      tags 'Cast Channel'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit cast channel' do
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
    end
  end

  path '/api/v1/branding' do
    get 'Get branding list' do
      tags 'Branding'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }

      response '200', 'branding list' do
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
    post 'Creates branding' do
      tags 'Branding'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string },
          "logo": { type: :file },
          "favicon": { type: :file }
        },
        required: %i[logo name]
      }

      response '201', 'branding created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'branding error' do
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
  path '/api/v1/branding/main' do
    get 'Show main branding' do
      tags 'Branding'
      consumes 'multipart/form-data'
      produces 'application/json'

      response '200', 'show branding' do
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
    end
  end
  path '/api/v1/branding/{id}' do
    get 'Show branding' do
      tags 'Branding'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show branding' do
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
    end
    put 'Update branding' do
      tags 'Branding'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string },
          "logo": { type: :file },
          "favicon": { type: :file }
        },
        required: %i[logo name]
      }

      response '200', 'branding updated' do
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

      response '422', 'branding error' do
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
    delete 'Delete branding' do
      tags 'Branding'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'branding created' do
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

      response '422', 'branding error' do
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
  path '/api/v1/branding/{id}/edit' do
    get 'Edit branding' do
      tags 'Branding'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'branding team' do
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
    end
  end
  path '/api/v1/branding/change' do
    put 'Update main branding' do
      tags 'Branding'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "id": { type: :integer }
        },
        required: %i[id]
      }

      response '200', 'branding updated' do
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

      response '422', 'branding error' do
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
  path '/api/v1/branding/{id}/soft_destroy' do
    delete 'Soft destroy branding' do
      tags 'Branding'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'branding deleted' do
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

      response '422', 'branding error' do
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
  path '/api/v1/branding/{id}/restore' do
    put 'Restore deleted branding' do
      tags 'Branding'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'restore branding' do
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

      response '422', 'restore branding' do
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
  path '/api/v1/teams' do
    get 'Get teams list' do
      tags 'Team'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }
      parameter name: :with_history, in: :query, type: :boolean, default: false

      response '200', 'teams list' do
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
    post 'Creates cast teams' do
      tags 'Team'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "game_discipline_id": { type: :integer },
          "name": { type: :string },
          "keyword": { type: :string }
        },
        required: %i[game_discipline_id name]
      }

      response '201', 'team created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'team error' do
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
  path '/api/v1/teams/{id}' do
    get 'Show team' do
      tags 'Team'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show team' do
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
    end
    put 'Update team' do
      tags 'Team'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "game_discipline_id": { type: :integer },
          "name": { type: :string },
          "keyword": { type: :string }
        },
        required: %i[game_discipline_id name]
      }

      response '200', 'team updated' do
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

      response '422', 'team error' do
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
    delete 'Delete team' do
      tags 'Team'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'team created' do
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

      response '422', 'team error' do
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
  path '/api/v1/teams/{id}/soft_destroy' do
    delete 'Soft destroy Team' do
      tags 'Team'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'team deleted' do
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

      response '422', 'team error' do
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
  path '/api/v1/teams/{id}/restore' do
    put 'Restore deleted team' do
      tags 'Team'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'restore team' do
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

      response '422', 'restore team' do
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
  path '/api/v1/teams/{id}/edit' do
    get 'Edit team' do
      tags 'Team'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit team' do
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
    end
  end

  path '/api/v1/sponsors' do
    get 'Get sponsors list' do
      tags 'Sponsor'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[only_deleted]
      }
      parameter name: :with_history, in: :query, type: :boolean, default: false

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
    post 'Creates cast sponsors' do
      tags 'Sponsor'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string }
        },
        required: %i[name]
      }

      response '201', 'sponsor created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'sponsor error' do
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
  path '/api/v1/sponsors/{id}' do
    get 'Show sponsor' do
      tags 'Sponsor'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show sponsor' do
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
    end
    put 'Update sponsor' do
      tags 'Sponsor'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string }
        },
        required: %i[name]
      }

      response '200', 'sponsor updated' do
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

      response '422', 'sponsor error' do
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
    delete 'Delete sponsor' do
      tags 'Sponsor'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'sponsor created' do
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

      response '422', 'sponsor error' do
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
  path '/api/v1/sponsors/{id}/soft_destroy' do
    delete 'Soft destroy sponsor' do
      tags 'Sponsor'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'sponsor deleted' do
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

      response '422', 'sponsor error' do
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
  path '/api/v1/sponsors/{id}/restore' do
    put 'Restore deleted sponsor' do
      tags 'Sponsor'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'restore sponsor' do
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

      response '422', 'restore sponsor' do
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
  path '/api/v1/sponsors/{id}/edit' do
    get 'Edit sponsor' do
      tags 'Sponsor'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit sponsor' do
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
    end
  end

  path '/api/v1/regions' do
    get 'Get regions list' do
      tags 'Region'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string

      response '200', 'regions list' do
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
    post 'Creates cast regions' do
      tags 'Region'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string }
        },
        required: %i[name]
      }

      response '201', 'region created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'region error' do
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
  path '/api/v1/regions/{id}' do
    get 'Show region' do
      tags 'Region'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show region' do
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
    end
    put 'Update region' do
      tags 'Region'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string }
        },
        required: %i[name]
      }

      response '200', 'region updated' do
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

      response '422', 'region error' do
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
    delete 'Delete region' do
      tags 'Region'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'region created' do
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

      response '422', 'region error' do
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
  path '/api/v1/regions/{id}/edit' do
    get 'Edit region' do
      tags 'Region'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit region' do
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
    end
  end

  path '/api/v1/corporates' do
    post 'Creates corporates' do
      tags 'Corporate'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string },
          "description": { type: :string },
          "start_at": { type: :string, format: "date-time" },
          "end_at": { type: :string, format: "date-time" },
          "location": { type: :string },
          "company_id": { type: :integer },
          "visible": { type: :boolean, enum: %w[true false] },
          "main_participant_ids": { type: :array },
          "participant_ids": { type: :array },
          "cover": { type: :file }
        },
        required: %i[name company_id start_at]
      }

      response '201', 'corporate created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'corporate error' do
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
  path '/api/v1/corporates/{id}' do
    get 'Show corporates' do
      tags 'Corporate'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show corporate' do
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
    end
    put 'Update corporates' do
      tags 'Corporate'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "name": { type: :string },
          "description": { type: :string },
          "start_at": { type: :string, format: "date-time" },
          "end_at": { type: :string, format: "date-time" },
          "location": { type: :string },
          "company_id": { type: :integer },
          "visible": { type: :boolean, enum: %w[true false] },
          "main_participant_ids": { type: :array },
          "participant_ids": { type: :array },
          "cover": { type: :file }
        },
        required: %i[name company_id start_at]
      }

      response '200', 'corporate created' do
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

      response '422', 'corporate error' do
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
    delete 'Delete corporates' do
      tags 'Corporate'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'corporate deleted' do
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

      response '422', 'corporate error' do
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
  path '/api/v1/corporates/{id}/edit' do
    get 'Edit corporates' do
      tags 'Corporate'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit corporate' do
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
    end
  end
  path '/api/v1/corporates/{id}/comments' do
    get 'Show corporate comments' do
      tags 'Corporate'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show corporate comments' do
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
    end
  end

  path '/api/v1/corporate_companies' do
    get 'Get corporate companies list' do
      tags 'Corporate Company'
      produces 'application/json'
      parameter name: :term, in: :query

      response '200', 'user companies list' do
        schema type: :object,
               properties: {
                 success: {
                   type: :boolean,
                   default: true
                 },
                 data: { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'Error response' do
        schema type: :object,
               properties: {
                 success: {
                   type: :boolean,
                   default: false
                 },
                 errors: { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    post 'Create company' do
      tags 'Corporate Company'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "title": { type: :string },
          "keyword": { type: :string },
          "cover": { type: :file }
        },
        required: %i[title cover]
      }

      response '201', 'corporate company created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'corporate company error' do
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
  path '/api/v1/corporate_companies/{id}' do
    get 'Show company' do
      tags 'Corporate Company'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show corporate company' do
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
    end
    put 'Update company' do
      tags 'Corporate Company'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "title": { type: :string },
          "keyword": { type: :string },
          "cover": { type: :file }
        },
        required: %i[title cover]
      }

      response '200', 'corporate company updated' do
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

      response '422', 'corporate company error' do
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
    delete 'Delete company' do
      tags 'Corporate Company'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'corporate company deleted' do
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

      response '422', 'corporate company error' do
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
  path '/api/v1/corporate_companies/{id}/edit' do
    get 'Edit company' do
      tags 'Corporate Company'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit corporate company' do
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
    end
  end

  path '/api/v1/entity_comments' do
    get 'Get entity comment list' do
      tags 'Entity Comment'
      produces 'application/json'
      parameter name: :entity_id, in: :query, type: :string
      parameter name: :entity_type, in: :query, schema: {
        type: :string,
        enum: %w[Tournament Match Corporate]
      }

      response '200', 'Returns the list of entity comments' do
        schema type: :object,
               properties: {
                 success: {
                   type: :boolean,
                   default: true
                 },
                 data: { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'Error response' do
        schema type: :object,
               properties: {
                 success: {
                   type: :boolean,
                   default: false
                 },
                 errors: { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    post 'Creates entity comment' do
      tags 'Entity Comment'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "message": { type: :string },
          "entity_type": { type: :integer },
          "visible": { type: :boolean, enum: %w[true false] },
          "entity_id": { type: :integer },
          "cover": { type: :file }
        },
        required: %i[message entity_type entity_id]
      }

      response '201', 'entity comment created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'entity comment error' do
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
  path '/api/v1/entity_comments/{id}' do
    get 'Show entity comment' do
      tags 'Entity Comment'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show tournament' do
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
    end
    put 'Update entity comment' do
      tags 'Entity Comment'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "message": { type: :string },
          "entity_type": { type: :integer },
          "entity_id": { type: :integer },
          "cover": { type: :file }
        },
        required: %i[message entity_type entity_id]
      }

      response '200', 'entity comment updated' do
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

      response '422', 'entity comment error' do
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
    delete 'Delete entity comment' do
      tags 'Entity Comment'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'entity comment created' do
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

      response '422', 'entity comment error' do
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
  path '/api/v1/entity_comments/{id}/edit' do
    get 'Edit entity comment' do
      tags 'Entity Comment'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit tournament' do
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
    end
  end

  path '/api/v1/user_disciplines' do
    get 'Get user_disciplines list' do
      tags 'User Discipline'
      produces 'application/json'

      parameter name: :term, in: :query, type: :string

      response '200', 'user_disciplines list' do
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
    post 'Creates user_discipline' do
      tags 'User Discipline'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "title": { type: :string }
        },
        required: %i[title cover]
      }

      response '201', 'user_discipline created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'user_discipline error' do
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
  path '/api/v1/user_disciplines/{id}' do
    get 'Show user_discipline' do
      tags 'User Discipline'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show user_discipline' do
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
    end
    put 'Update user_discipline' do
      tags 'User Discipline'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "title": { type: :string }
        },
        required: %i[title cover]
      }

      response '200', 'user_discipline updated' do
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

      response '422', 'user_discipline error' do
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
    delete 'Delete user_discipline' do
      tags 'User Discipline'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'user_discipline deleted' do
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

      response '422', 'user_discipline error' do
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
  path '/api/v1/user_disciplines/{id}/edit' do
    get 'Edit user_discipline' do
      tags 'User Discipline'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit user_discipline' do
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
    end
  end

  path '/api/v1/users' do
    get 'Get users list' do
      tags 'User'
      produces 'application/json'
      parameter name: :term, in: :query, type: :string
      parameter name: :scope, in: :query, schema: {
        type: :string,
        enum: %w[staff_members participants main_participants media_representatives commentators analytics managers
                 only_deleted]
      }

      response '200', 'Returns the list of users' do
        schema type: :object,
               properties: {
                 success: {
                   type: :boolean,
                   default: true
                 },
                 data: { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'Error response' do
        schema type: :object,
               properties: {
                 success: {
                   type: :boolean,
                   default: false
                 },
                 errors: { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    post 'Create user' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "first_name": { type: :string },
          "last_name": { type: :string },
          "nick": { type: :string },
          "avatar": { type: :file },
          "email": { type: :string },
          "company_id": { type: :integer },
          "time_zone": { type: :string },
          "google_calendar_status": { type: :boolean, enum: %w[true false] },
          "google_calendar_required": { type: :boolean, enum: %w[true false] },
          "role_ids": { type: :array },
          "user_discipline_ids": { type: :array }
        },
        required: %i[role_id email]
      }

      response '200', 'user created' do
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

      response '422', 'user create error' do
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
  path '/api/v1/users/{id}' do
    get 'Show user' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show user' do
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
    end
    put 'Update user' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "first_name": { type: :string },
          "last_name": { type: :string },
          "time_zone": { type: :string },
          "nick": { type: :string },
          "role_ids": { type: :array },
          "user_discipline_ids": { type: :array },
          "google_calendar_status": { type: :boolean, enum: %w[true false] },
          "google_calendar_required": { type: :boolean, enum: %w[true false] }
        },
        required: %i[nick role_id]
      }

      response '200', 'user updated' do
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

      response '422', 'user error' do
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
    delete 'Delete user' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'user deleted' do
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

      response '422', 'user error' do
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
  path '/api/v1/users/{id}/resent_invite' do
    delete 'Soft destroy for user' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'user soft destroy' do
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

      response '422', 'user soft delete' do
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
  path '/api/v1/users/{id}/soft_destroy' do
    delete 'Soft destroy for user' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :hide_history, in: :query, type: :boolean, required: false

      response '200', 'user soft destroy' do
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

      response '422', 'user soft delete' do
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
  path '/api/v1/users/{id}/restore' do
    put 'Restore deleted user' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'restore user' do
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

      response '422', 'restore user' do
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
  path '/api/v1/users/{id}/notifications' do
    get 'Show notifications of user' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false
      parameter name: :start_id, in: :query, type: :integer, required: false

      response '200', 'show notifications of user' do
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
    end
  end
  path '/api/v1/users/change_password' do
    put 'Update user password' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "user[current_password]": { type: :string },
          "user[password]": { type: :string },
          "user[password_confirmation]": { type: :string }
        },
        required: %i[current_password password password_confirmation]
      }

      response '200', 'user password updated' do
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

      response '422', 'user password error' do
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
  path '/api/v1/users/authenticated' do
    get 'Show authenticated user' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      response '200', 'show authenticated user' do
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
    end
  end
  path '/api/v1/users/permissions' do
    get 'Show authenticated user permissions' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      response '200', 'show user permissions' do
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
    end
  end
  path '/api/v1/users/authenticated/notifications' do
    get 'Show notifications of authenticated user' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false
      parameter name: :start_id, in: :query, type: :integer, required: false

      response '200', 'show notifications of authenticated user' do
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
    end
  end
  path '/api/v1/users/authenticated/notifications/count' do
    get 'Show count unread notifications of authenticated user' do
      tags 'User'
      consumes 'multipart/form-data'
      produces 'application/json'

      response '200', 'show notifications of authenticated user' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": {
                   type: :object,
                   properties: {
                     "count": {
                       type: :integer
                     }
                   }
                 }
               }

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  path '/api/v1/user_notifications/read' do
    post 'Mark as Read' do
      tags 'User Notifications'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "id": { type: :integer }
        }
      }

      response '200', 'user notifications mark as reed' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { default: :null }
               }

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'user notifications error' do
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

  path '/api/v1/roles' do
    get 'Get user roles list' do
      tags 'Role'
      produces 'application/json'

      response '200', 'roles list' do
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
    post 'Create role' do
      tags 'Role'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "title": { type: :string },
          "descriptions": { type: :string },
          "permissions": { type: :array }
        },
        required: %i[title cover]
      }

      response '201', 'role created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'role error' do
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
  path '/api/v1/roles/permissions' do
    get 'Get user permissions list' do
      tags 'Role'
      produces 'application/json'

      response '200', 'permissions list' do
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
  path '/api/v1/roles/{id}' do
    get 'Show role' do
      tags 'Role'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show role' do
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
    end
    put 'Update role' do
      tags 'Role'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "title": { type: :string },
          "description": { type: :string },
          "permissions": { type: :array }
        },
        required: %i[title cover]
      }

      response '200', 'role updated' do
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

      response '422', 'role error' do
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
    delete 'Delete role' do
      tags 'Role'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'role deleted' do
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

      response '422', 'role error' do
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
  path '/api/v1/roles/{id}/edit' do
    get 'Edit role' do
      tags 'Role'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit role' do
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
    end
  end

  path '/api/v1/user_companies' do
    get 'Get user companies list' do
      tags 'User Company'
      produces 'application/json'
      parameter name: :term, in: :query

      response '200', 'user companies list' do
        schema type: :object,
               properties: {
                 success: {
                   type: :boolean,
                   default: true
                 },
                 data: { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end

      response '422', 'Error response' do
        schema type: :object,
               properties: {
                 success: {
                   type: :boolean,
                   default: false
                 },
                 errors: { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    post 'Create company' do
      tags 'User Company'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "title": { type: :string },
          "keyword": { type: :string },
          "cover": { type: :file }
        },
        required: %i[title cover]
      }

      response '201', 'user company created' do
        schema type: :object,
               properties: {
                 "success": {
                   type: :boolean,
                   default: true
                 },
                 "data": { type: :object }
               }

        run_test! do
          expect(response).to have_http_status(:created)
        end
      end

      response '422', 'user company error' do
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
  path '/api/v1/user_companies/{id}' do
    get 'Show company' do
      tags 'User Company'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'show user company' do
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
    end
    put 'Update company' do
      tags 'User Company'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :entity, in: :formData, schema: {
        type: :object,
        properties: {
          "title": { type: :string },
          "keyword": { type: :string },
          "cover": { type: :file },
          "user_ids": { type: :array }
        },
        required: %i[title cover]
      }

      response '200', 'user company updated' do
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

      response '422', 'user company error' do
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
    delete 'Delete company' do
      tags 'User Company'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'user company deleted' do
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

      response '422', 'user company error' do
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
  path '/api/v1/user_companies/{id}/edit' do
    get 'Edit company' do
      tags 'User Company'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'edit user company' do
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
    end
  end
  path '/api/v1/items' do
    get 'Get managment items and counts' do
      tags 'Managment Items'
      consumes 'multipart/form-data'
      produces 'application/json'

      response '200', 'managment items' do
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
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class MatchesController < BaseCrudController

      def index
        authorize resource_class

        data = resource_class::List.call(search_params, current_user)
        render_json_response(true, data, :ok)
      end

      def show
        authorize resource

        data = resource_class::Show.call(resource, current_user)
        render_json_response(true, data, :ok)
      end

      def types
        authorize Match

        result = Match::BEST_OF
        render_json_response(true, result, :ok)
      end

      def create
        authorize Match

        match_params_with_discipline = prepare_match_params(resource_params)
        data = Match::Create.call(match_params_with_discipline, current_user)
        handle_entity_result(data, :ok)
      end

      def update
        authorize resource

        match_params_with_discipline = prepare_match_params(resource_params)
        data = Match::Update.call(resource, match_params_with_discipline, current_user)
        handle_entity_result(data, :ok)
      end

      def soft_destroy
        authorize match

        data = resource_class::SoftDestroy.call(match, current_user)
        render_json_response(true, data, :ok)
      end

      def restore
        authorize deleted_match

        data = resource_class::Restore.call(deleted_match, current_user)
        render_json_response(true, data, :ok)
      end

      def destroy
        authorize deleted_match

        data = resource_class::Delete.call(deleted_match, current_user)
        handle_entity_result(data, :ok)
      end

      def bulk_destroy
        authorize deleted_matches

        data = resource_class::Delete.call(deleted_matches, current_user, bulk: true)
        render_json_response(true, data, :ok)
      end

      def bulk_restore
        authorize deleted_matches

        data = resource_class::Restore.call(deleted_matches, current_user, bulk: true)
        render_json_response(true, data, :ok)
      end

      def bulk_soft_destroy
        authorize matches

        data = resource_class::SoftDestroy.call(matches, current_user, bulk: true)
        render_json_response(true, data, :ok)
      end

      private

      def search_params
        params.permit(%i[scope])
      end

      def resource_class
        Match
      end

      def prepare_match_params(match_params)
        tournament = Tournament.find(match_params[:tournament_id])
        discipline_id = tournament.game_discipline_id

        match_params[:team_one_attributes][:game_discipline_id] = discipline_id if match_params[:team_one_attributes]
        match_params[:team_two_attributes][:game_discipline_id] = discipline_id if match_params[:team_two_attributes]

        match_params
      end

      def resource
        @resource = if current_user.permission?(resource_class.name, :visible)
                      resource_class.find(params[:id])
                    else
                      resource_class.only_visible_join_tournament.find(params[:id])
                    end
      end

      def resource_params
        params.permit(
          :id,
          :tournament_id,
          :start_at,
          :end_at,
          :best_of,
          :team_one_id,
          :team_two_id,
          :visible,
          team_one_attributes: %i[name game_discipline_id],
          team_two_attributes: %i[name game_discipline_id],
          match_cast_ids: [],
          match_casts_attributes: [
            :id,
            :_destroy,
            :cast_language_id,
            :cast_studio_id,
            :backup_commentator_id,
            :host_analytic_id,
            :cast_analytic_studio_id,
            {
              cast_channel_ids: [],
              analytic_ids: [],
              commentator_ids: [],
              staff_member_ids: [],
              match_backup_commentator_attributes: [:user_id],
              match_host_analytic_attributes: [:user_id]
            }
          ]
        )
      end

      def restore_ids_param
        params.permit(ids: [])[:ids] || []
      end

      def deleted_matches
        @deleted_matches = resource_class.only_deleted.where(id: restore_ids_param)
      end

      def matches
        @matches = resource_class.where(id: restore_ids_param)
      end

      def deleted_match
        @deleted_match = resource_class.only_deleted.find(params[:id])
      end

      def match
        @match = resource_class.find(params[:id])
      end

    end
  end
end

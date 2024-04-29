# frozen_string_literal: true

module Api
  module V1
    class TournamentsController < BaseCrudController

      def media
        authorize resource

        data = Tournament::MediaList.call(resource&.media)
        render_json_response(true, data, :ok)
      end

      def schedule
        authorize resource

        data = Tournament::Schedule.call(resource, @current_user)
        render_json_response(true, data, :ok)
      end

      def comments
        authorize resource

        data = Tournament::CommentList.call(resource&.comments)
        render_json_response(true, data, :ok)
      end

      def types
        authorize Tournament

        data = TournamentContext::Type::List.call(tournament_types_search_params)
        render_json_response(true, data, :ok)
      end

      def create
        authorize resource_class

        data = resource_class::Create.call(resource_params, current_user)
        handle_entity_result(data, :ok)
      end

      def update
        authorize resource

        data = resource_class::Update.call(resource, resource_params, current_user)
        handle_entity_result(data, :ok)
      end

      def destroy
        authorize deleted_tournament

        data = resource_class::Delete.call(deleted_tournament, current_user)
        handle_entity_result(data, :ok)
      end

      def soft_destroy
        authorize resource

        data = resource_class::SoftDestroy.call(resource, current_user)

        render_json_response(true, data, :ok)
      end

      def restore
        authorize deleted_tournament

        data = resource_class::Restore.call(deleted_tournament, current_user)
        render_json_response(true, data, :ok)
      end

      private

      def resource_class
        Tournament
      end

      def search_params
        params.permit(%i[game_discipline_id term scope year])
      end

      def tournament_types_search_params
        params.permit(%i[term])
      end

      def resource
        @resource = if current_user.permission?(resource_class.name, :visible)
                      resource_class.find(params[:id])
                    else
                      resource_class.only_visible.find(params[:id])
                    end
      end

      def deleted_tournament
        @deleted_tournament = resource_class.only_deleted.find(params[:id])
      end

      def resource_params
        params.permit(
          :id,
          :game_discipline_id,
          :title,
          :start_at,
          :end_at,
          :region_id,
          :type_id,
          :owner_id,
          :visible,
          :cover,
          :top,
          main_participant_ids: [],
          media_representative_ids: [],
          sponsor_ids: [],
          descriptions_attributes: %i[id title description _destroy],
          media_attributes: %i[id title description _destroy],
          sponsors_attributes: %i[name]
        )
      end

    end
  end
end

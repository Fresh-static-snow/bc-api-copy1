# frozen_string_literal: true

module Api
  module V1
    class SegmentsController < MatchesController

      def media
        authorize resource

        data = resource_class::MediaList.call(resource.media)
        render_json_response(true, data, :ok)
      end

      def comments
        authorize resource

        data = resource_class::CommentList.call(resource.comments)
        render_json_response(true, data, :ok)
      end

      private

      def resource_class
        Segment
      end

      def resource
        @resource = if current_user.permission?(resource_class.name, :visible)
                      Segment.find(params[:id])
                    else
                      Segment.only_visible_join_tournament.find(params[:id])
                    end
      end

      def resource_params
        params.permit(
          :id,
          :tournament_id,
          :title,
          :start_at,
          :end_at,
          :visible,
          :best_of,
          :cover,
          :logo,
          guests_attributes: %i[
            id
            name
            username
            social
            _destroy
          ],
          descriptions_attributes: %i[
            id
            title
            description
            _destroy
          ],
          media_attributes: %i[
            id
            title
            description
            _destroy
          ],
          match_cast_ids: [],
          match_casts_attributes: [
            :id,
            :_destroy,
            :cast_language_id,
            :cast_studio_id,
            :cast_setup_id,
            :cast_stream_id,
            :cast_analytic_studio_id,
            {
              cast_channel_ids: [],
              analytic_ids: [],
              commentator_ids: [],
              staff_member_ids: [],
              backup_commentator_ids: [],
              match_host_analytic_attributes: [:user_id]
            }
          ]
        )
      end

      def deleted_matches
        @deleted_matches = Segment.only_deleted.where(id: restore_ids_param)
      end

      def matches
        @matches = Segment.where(id: restore_ids_param)
      end

      def deleted_match
        @deleted_match = Segment.only_deleted.find(params[:id])
      end

      def match
        @match = Segment.find(params[:id])
      end

    end
  end
end

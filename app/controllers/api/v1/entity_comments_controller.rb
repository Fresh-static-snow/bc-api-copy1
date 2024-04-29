# frozen_string_literal: true

module Api
  module V1
    class EntityCommentsController < BaseCrudController

      private

      def resource_class
        EntityComment
      end

      def search_params
        params.permit(
          :entity_type,
          :entity_id
        )
      end

      def resource_params
        params.permit(
          :id,
          :entity_type,
          :entity_id,
          :message,
          :cover
        ).merge(user: current_user)
      end

    end
  end
end

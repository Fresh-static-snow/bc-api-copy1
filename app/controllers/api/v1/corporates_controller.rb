# frozen_string_literal: true

module Api
  module V1
    class CorporatesController < BaseCrudController

      def comments
        resource = resource_class.find(params[:id])
        authorize resource

        data = Corporate::CommentList.call(resource&.comments)
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
        authorize resource

        data = resource_class::Delete.call(resource, current_user)
        handle_entity_result(data, :ok)
      end

      private

      def resource_class
        Corporate
      end

      def resource
        @resource = if current_user.permission?(resource_class.name, :visible)
                      resource_class.find(params[:id])
                    else
                      resource_class.only_visible.find(params[:id])
                    end
      end

      def resource_params
        params.permit(
          :id,
          :cover,
          :name,
          :description,
          :start_at,
          :end_at,
          :location,
          :company_id,
          :visible,
          main_participant_ids: [],
          participant_ids: []
        )
      end

    end
  end
end

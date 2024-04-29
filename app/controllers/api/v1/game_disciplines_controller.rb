# frozen_string_literal: true

module Api
  module V1
    class GameDisciplinesController < BaseCrudController

      private

      def resource_class
        GameDiscipline
      end

      def search_params
        params.permit(:scope, :term)
      end

      def resource_params
        params.permit(
          :id,
          :title,
          :keyword,
          :cover
        )
      end

    end
  end
end

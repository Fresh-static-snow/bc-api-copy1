# frozen_string_literal: true

module CastContext
  class Studio
    class Delete < BaseDeleteService

      def call
        HistoryService.hide_history(resource)

        super
      end

    end
  end
end

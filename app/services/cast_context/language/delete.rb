# frozen_string_literal: true

module CastContext
  class Language
    class Delete < BaseDeleteService

      def call
        HistoryService.hide_history(resource)

        super
      end

    end
  end
end

# frozen_string_literal: true

module CastContext
  class Channel
    class Restore < BaseRestoreService

      def call
        HistoryService.recover_history(resource)

        super
      end

    end
  end
end

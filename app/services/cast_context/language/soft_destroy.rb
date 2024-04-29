# frozen_string_literal: true

module CastContext
  class Language
    class SoftDestroy < BaseSoftDestroyService

      def call
        HistoryService.hide_history(resource, soft_destroy: true)

        super
      end

    end
  end
end

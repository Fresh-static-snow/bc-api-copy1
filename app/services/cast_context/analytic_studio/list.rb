# frozen_string_literal: true

module CastContext
  class AnalyticStudio
    class List < BaseListService

      def call
        CastContext::AnalyticStudioSerializer.render_as_hash(resource, view: scope)
      end

    end
  end
end

# frozen_string_literal: true

module CastContext
  class AnalyticStudio
    class Show < BaseShowService

      def call
        CastContext::AnalyticStudioSerializer.render_as_hash(resource, view: :list)
      end

    end
  end
end

# frozen_string_literal: true

module CastContext
  class Studio
    class Show < BaseShowService

      def call
        CastContext::StudioSerializer.render_as_hash(resource, view: :list)
      end

    end
  end
end

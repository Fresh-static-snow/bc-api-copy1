# frozen_string_literal: true

module CastContext
  class Studio
    class List < BaseListService

      def call
        CastContext::StudioSerializer.render_as_hash(resource, view: scope)
      end

    end
  end
end

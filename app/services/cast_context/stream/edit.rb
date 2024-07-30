# frozen_string_literal: true

module CastContext
  class Stream
    class Edit < BaseEditService

      def call
        CastContext::StreamSerializer.render_as_hash(resource, view: :list)
      end

    end
  end
end

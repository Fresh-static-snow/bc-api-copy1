# frozen_string_literal: true

module CastContext
  class Stream
    class List < BaseListService

      def call
        CastContext::StreamSerializer.render_as_hash(resource, view: scope)
      end

    end
  end
end

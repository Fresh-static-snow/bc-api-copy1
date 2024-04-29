# frozen_string_literal: true

module CastContext
  class Channel
    class List < BaseListService

      def call
        CastContext::ChannelSerializer.render_as_hash(resource, view: scope)
      end

    end
  end
end

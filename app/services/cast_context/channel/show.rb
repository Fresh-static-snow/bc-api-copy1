# frozen_string_literal: true

module CastContext
  class Channel
    class Show < BaseShowService

      def call
        CastContext::ChannelSerializer.render_as_hash(resource, view: :list)
      end

    end
  end
end

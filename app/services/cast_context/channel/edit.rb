# frozen_string_literal: true

module CastContext
  class Channel
    class Edit < BaseEditService

      def call
        CastContext::ChannelSerializer.render_as_hash(resource, view: :list)
      end

    end
  end
end

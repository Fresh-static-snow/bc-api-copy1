# frozen_string_literal: true

module CastContext
  class Setup
    class Edit < BaseEditService

      def call
        CastContext::SetupSerializer.render_as_hash(resource, view: :list)
      end

    end
  end
end

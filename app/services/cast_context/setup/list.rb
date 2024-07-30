# frozen_string_literal: true

module CastContext
  class Setup
    class List < BaseListService

      def call
        CastContext::SetupSerializer.render_as_hash(resource, view: scope)
      end

    end
  end
end

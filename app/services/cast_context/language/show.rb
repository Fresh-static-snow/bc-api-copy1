# frozen_string_literal: true

module CastContext
  class Language
    class Show < BaseShowService

      def call
        CastContext::LanguageSerializer.render_as_hash(resource, view: :list)
      end

    end
  end
end

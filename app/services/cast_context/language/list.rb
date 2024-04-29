# frozen_string_literal: true

module CastContext
  class Language
    class List < BaseListService

      def call
        CastContext::LanguageSerializer.render_as_hash(resource, view: scope)
      end

    end
  end
end

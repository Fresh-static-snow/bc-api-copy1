# frozen_string_literal: true

module TournamentContext
  class Type
    class List < BaseListService

      def call
        TournamentContext::TypeSerializer.render_as_hash(resource, view: :list)
      end

    end
  end
end

# frozen_string_literal: true

module StreamModule
  module Scopes

    extend ActiveSupport::Concern

    included do
      scope :filter_by_term, -> (term) {
        if term.present?
          where(
            'lower(name) ILIKE ?',
            "%#{sanitize_sql_like(term.downcase)}%"
          )
        end
      }
    end

  end
end

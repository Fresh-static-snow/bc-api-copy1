# frozen_string_literal: true

module LanguageModule
  module Scopes

    extend ActiveSupport::Concern

    included do
      scope :filter_by_term, -> (term) {
        if term.present?
          where(
            'lower(name) ILIKE ? OR lower(keyword) ILIKE ?',
            "%#{sanitize_sql_like(term.downcase)}%",
            "%#{sanitize_sql_like(term.downcase)}%"
          )
        end
      }
    end

  end
end

# frozen_string_literal: true

module RegionModule
  module Scopes

    extend ActiveSupport::Concern

    included do
      scope :filter_by_term, -> (term) {
        if term.present?
          where(
            'lower(name) ILIKE ? OR lower(code) ILIKE ?',
            "%#{sanitize_sql_like(term.downcase)}%",
            "%#{sanitize_sql_like(term.downcase)}%"
          )
        end
      }
    end

  end
end

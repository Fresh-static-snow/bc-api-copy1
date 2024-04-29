# frozen_string_literal: true

module OwnerModule
  module Scopes

    extend ActiveSupport::Concern

    included do
      scope :filter_by_term, -> (term) {
        where('lower(name) ILIKE ?', "%#{sanitize_sql_like(term.downcase)}%") if term.present?
      }
    end

  end
end

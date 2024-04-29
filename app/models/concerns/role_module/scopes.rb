# frozen_string_literal: true

module RoleModule
  module Scopes

    extend ActiveSupport::Concern

    included do
      scope :filter_by_term, -> (term) {
        where('lower(title) ILIKE ?', "%#{sanitize_sql_like(term.downcase)}%") if term.present?
      }
    end

  end
end

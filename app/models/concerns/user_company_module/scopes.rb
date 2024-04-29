# frozen_string_literal: true

module UserCompanyModule
  module Scopes

    extend ActiveSupport::Concern

    included do
      scope :filter_by_term, -> (term) {
        where('LOWER(title) ILIKE ?', "%#{sanitize_sql_like(term.downcase)}%") if term.present?
      }

      scope :sort_by_title, -> { order(:title) }
    end

  end
end

# frozen_string_literal: true

module TeamModule
  module Scopes

    extend ActiveSupport::Concern

    included do
      scope :filter_by_game_discipline_id, -> (game_discipline_id) { where(game_discipline_id: game_discipline_id) }
      scope :filter_by_term, -> (term) {
        where('lower(name) ILIKE ?', "%#{sanitize_sql_like(term.downcase)}%") if term.present?
      }
      scope :sort_by_name, -> { order(:name) }
    end

  end
end

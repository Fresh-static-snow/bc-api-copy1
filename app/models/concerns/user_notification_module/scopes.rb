# frozen_string_literal: true

module UserNotificationModule
  module Scopes

    extend ActiveSupport::Concern

    included do
      scope :filter_by_term, -> (term) {
        where('lower(title) ILIKE ?', "%#{sanitize_sql_like(term.downcase)}%") if term.present?
      }
      scope :sort_by_date, -> { order(created_at: :desc) }

      scope :filter_by_user, -> (user_id) {
        where(user_id: user_id)
      }

      scope :management, -> {
        where(personal: false)
      }

      scope :calendar, -> {
        where(personal: true)
      }
    end

  end
end

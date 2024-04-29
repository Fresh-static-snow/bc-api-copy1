# frozen_string_literal: true

module UserModule
  module Scopes

    extend ActiveSupport::Concern

    included do
      scope :participants, -> { all }
      scope :main_participants, -> { joins(:user_disciplines).where(user_disciplines: { title: 'Main Participant' }) }
      scope :media_representatives, -> {
        joins(:user_disciplines).where(user_disciplines: { title: 'Media Representative' })
      }
      scope :commentators, -> { joins(:user_disciplines).where(user_disciplines: { title: 'Commentator' }) }
      scope :analytics, -> { joins(:user_disciplines).where(user_disciplines: { title: 'Analytic' }) }
      scope :staff_members, -> { joins(:user_disciplines).where(user_disciplines: { title: 'Staff' }) }
      scope :managers, -> { joins(:user_disciplines).where(user_disciplines: { title: 'Manager' }) }

      scope :with_permission, -> (permission_id) {
        joins(user_roles: :role).where('roles.permissions @> ?::jsonb', "[{\"id\": \"#{permission_id}\"}]")
      }

      scope :filter_by_term, -> (term) {
        if term.present?
          where(
            "lower(email) ILIKE ?
                OR lower(nick) ILIKE ?
                OR lower(first_name) ILIKE ?
                OR lower(last_name) ILIKE ?",
            "%#{sanitize_sql_like(term.downcase)}%",
            "%#{sanitize_sql_like(term.downcase)}%",
            "%#{sanitize_sql_like(term.downcase)}%",
            "%#{sanitize_sql_like(term.downcase)}%"
          )
        end
      }

      scope :with_history, -> { where(hide_history: false) }
      scope :sort_by_display_name, -> { order(:display_name) }

      scope :managment_staff, -> {
                                includes(:user_disciplines)
                                  .where(user_disciplines: { title: ['Manager', 'Participant',
                                                                     'Main Participant', 'Media Representative'] })
                              }
    end

  end
end

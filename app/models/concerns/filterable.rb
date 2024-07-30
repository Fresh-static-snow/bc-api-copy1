# frozen_string_literal: true

module Filterable

  extend ActiveSupport::Concern

  # filter_by_game_discipline TODO
  OR_SCOPES = %w[
    filter_by_studio
    filter_by_analytic_studio
    filter_by_setup
    filter_by_stream
    filter_by_channels
    filter_by_managers
    filter_by_main_participants
    filter_by_media_representatives
    filter_by_staff_members
    filter_by_analytics
    filter_by_commentators
    filter_by_host_analytic
    filter_by_backup_commentators
  ].freeze

  module ClassMethods

    def filter(filtering_params, payload = nil)
      results = payload || all

      # in_or_scopes = filtering_params.select { |key, _| OR_SCOPES.include?(key) }
      # not_in_or_scopes = filtering_params.reject { |key, _| OR_SCOPES.include?(key) }
      # sorted_filtering_params = not_in_or_scopes.merge(in_or_scopes)

      filtering_params.each do |key, value|
        next unless value.present?

        # results = string_filter(results, key, value.to_s)
        results = string_filter(results, key, value)
      end

      results
    end

    private

    DATE_DELIMITER = '-'

    def string_filter(results, key, stringified_value)
      # return results unless results.respond_to?("filter_by_#{key}")
      results.public_send("filter_by_#{key}", stringified_value)

      # if OR_SCOPES.include?("filter_by_#{key}")
      #   results.or(results.public_send("filter_by_#{key}", stringified_value))
      # else
      #   results.public_send("filter_by_#{key}", extract_date(stringified_value))
      # end
    end

    def extract_date(value)
      date, month, year = value.split(DATE_DELIMITER)
      return value unless date.is_a?(Integer) && month.is_a?(Integer) && year.is_a?(Integer)
      return Date.parse(value) if Date.valid_date?(date.to_i, month.to_i, year.to_i)

      value
    end

  end

end

# frozen_string_literal: true

class Calendar
  class List

    include CalendarParams
    include PeriodParams
    include ValidatePeriod
    include CalendarTournaments
    include CalendarMatches
    include CalendarCorporates

    attr_reader :params, :current_user, :scope, :calendar_params

    VIEW_MODES = %i[day week month quarter year].freeze

    def self.call(params, current_user)
      new(params, current_user).call
    end

    def initialize(params, current_user)
      @scope = params.delete(:scope)&.to_sym
      @params = params.except(:page, :per_page)
      @calendar_params = period_params
      @current_user = current_user
    end

    def call
      case view_mode
      when :quarter, :year
        tournaments + corporates
      else
        (matches + corporates).sort_by { |event| event[:date] }
      end
    end

    private

    def view_mode
      @view_mode ||= VIEW_MODES.include?(scope) ? scope : :day
    end

  end
end

# frozen_string_literal: true

module PeriodParams

  extend ActiveSupport::Concern

  included do
    private

    def period_params
      focused_date = params[:focused_date] || Time.zone.today

      send("period_for_#{view_mode}", focused_date)

      params.delete(:focused_date)

      params
    end

    def set_period(start_date, end_date)
      start_date = DateTime.parse("#{start_date} 00:00:00")
      end_date = DateTime.parse("#{end_date} 23:59:59")

      params[:period_from] = start_date
      params[:period_to] = end_date
    end

    def period_for_day(date)
      date_time = date.to_date
      set_period(date_time.beginning_of_day, date_time.end_of_day)
    end

    def period_for_week(date)
      start_of_week = date.to_date.beginning_of_week
      end_of_week = date.to_date.end_of_week
      set_period(start_of_week, end_of_week)
    end

    def period_for_month(date)
      start_of_month = date.to_date.beginning_of_month
      end_of_month = date.to_date.end_of_month
      set_period(start_of_month, end_of_month)
    end

    def period_for_quarter(date)
      start_of_quarter = date.to_date.beginning_of_quarter
      end_of_quarter = date.to_date.end_of_quarter
      set_period(start_of_quarter, end_of_quarter)
    end

    def period_for_year(date)
      start_of_year = date.to_date.beginning_of_year
      end_of_year = date.to_date.end_of_year
      set_period(start_of_year, end_of_year)
    end
  end

end

# frozen_string_literal: true

module CalendarParams

  extend ActiveSupport::Concern

  included do
    private

    def filter_params_for_filter
      calendar_params[:params] ||= {}

      %i[studio analytic_studio channel managers main_participants
         media_representatives staff_members analytics commentators host_analytic
         backup_commentators setup stream].each do |param|
        calendar_params[:params][param] = calendar_params[param] if calendar_params[param].present?
      end

      except_calendar_params
    end

    def filter_params_for_current_user
      calendar_params[:params] ||= {}

      %i[managers main_participants media_representatives staff_members analytics commentators host_analytic
         backup_commentators].each do |param|
        calendar_params[:params][param] = current_user.id
      end

      except_calendar_params
    end

    def except_calendar_params
      calendar_params.except(:current_user, :studio, :analytic_studio, :channel, :managers,
                             :main_participants, :media_representatives, :staff_members, :analytics,
                             :commentators, :host_analytic, :backup_commentators, :setup, :stream)
    end
  end

end

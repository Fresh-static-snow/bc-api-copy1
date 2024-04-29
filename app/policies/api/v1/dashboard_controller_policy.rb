# frozen_string_literal: true

module Api
  module V1
    class DashboardControllerPolicy < ApplicationPolicy

      def users?
        permission?(:users)
      end

      def companies?
        permission?(:companies)
      end

      def notifications?
        permission?(:notifications)
      end

      def counts?
        permission?(:counts)
      end

    end
  end
end

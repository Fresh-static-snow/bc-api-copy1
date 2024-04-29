# frozen_string_literal: true

module Api
  module V1
    class DashboardController < ApplicationController

      def users # rubocop:disable Metrics/AbcSize
        authorize DashboardController

        roles = Role.includes(:users).map do |role|
          users = role.users.filter_by_term(search_params[:term])
                      .includes(avatar_attachment: :blob, company: { cover_attachment: :blob }).sort_by_display_name
          {
            **RoleSerializer.render_as_hash(role, view: :common),
            user_count: users.length,
            users: UserSerializer.render_as_hash(users, view: :dashboard_list)
          }
        end

        users_without_roles = User.includes(:roles, { avatar_attachment: :blob })
                                  .select('users.id, users.display_name')
                                  .where(roles: { id: nil })
                                  .filter_by_term(search_params[:term])
                                  .sort_by_display_name

        roles = {} if roles.blank?
        roles.append(
          id: 0,
          description: nil,
          title: 'Without Roles',
          user_count: users_without_roles.count,
          users: UserSerializer.render_as_hash(users_without_roles, view: :dashboard_list)
        )

        render_json_response(
          true,
          roles,
          :ok
        )
      end

      def companies
        authorize DashboardController

        user_companies = UserCompany.filter(search_params)
                                    .includes(:users, { cover_attachment: :blob })
                                    .select('user_companies.id, user_companies.title')
                                    .sort_by_title

        render_json_response(
          true,
          serialize_user_companies(user_companies),
          :ok
        )
      end

      def notifications
        authorize DashboardController

        render_json_response(
          true,
          serialize_user_notifications,
          :ok
        )
      end

      def counts
        authorize DashboardController

        render_json_response(
          true,
          {
            roles_count: Role.select('id').count,
            users_count: User.select('id').count,
            companies_count: UserCompany.select('id').count
          },
          :ok
        )
      end

      private

      def serialize_user_companies(companies)
        UserCompanySerializer.render_as_hash(companies, view: :with_users_count)
      end

      def serialize_user_notifications
        User::Notifications.call(current_user, search_params.merge(scope: 'dashboard'))
      end

      def search_params
        params.permit(:term, :page, :per_page, :start_id)
      end

    end
  end
end

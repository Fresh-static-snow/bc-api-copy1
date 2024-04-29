# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController

      def index
        authorize User

        data = User::List.call(search_params)
        render_json_response(true, data, :ok)
      end

      def show
        authorize user

        data = User::Show.call(user)
        render_json_response(true, data, :ok)
      end

      def edit
        authorize user

        data = User::Edit.call(user)
        render_json_response(true, data, :ok)
      end

      def create
        authorize User

        data = User::Create.call(user_params, current_user)
        handle_entity_result(data, :ok)
      end

      def update
        authorize user

        data = User::Update.call(user, user_params, current_user)
        if data.errors.any?
          render_json_response(false, data.errors.full_messages, :unprocessable_entity)
        else
          render_json_response(true, UserSerializer.render_as_hash(data, view: :show), :ok)
        end
      end

      def update_avatar
        authorize user

        result = User::Update.call(user, update_avatar_params, current_user)
        handle_entity_result(result, :ok)
      end

      def change_password
        authorize current_user

        result = User::ChangePassword.call(current_user, password_params)

        if result[:success]
          bypass_sign_in(current_user)
          render_json_response(true, result[:message], :unauthorized)
        else
          render_json_response(false, result[:error], :unprocessable_entity)
        end
      end

      def soft_destroy
        authorize user

        data = User::SoftDestroy.call(user, soft_destroy_params, current_user)
        handle_entity_result(data, :ok)
      end

      def restore
        authorize deleted_user

        data = User::Restore.call(deleted_user, {})
        handle_entity_result(data, :ok)
      end

      def destroy
        authorize deleted_user

        data = User::Delete.call(deleted_user)
        handle_entity_result(data, :ok)
      end

      def resent_invite
        authorize user

        data = User::ResentInvite.call(user)
        handle_entity_result(data, :ok)
      end

      private

      def user
        @user = User.find(params[:id])
      end

      def deleted_user
        @deleted_user = User.only_deleted.find(params[:id])
      end

      def update_avatar_params
        params.permit(:id, :avatar)
      end

      def user_params
        params.permit(
          :id,
          :first_name,
          :last_name,
          :nick,
          :avatar,
          :email,
          :company_id,
          :skip_invitation,
          :google_calendar_required,
          :google_calendar_status,
          :telegram_chat_id,
          :discord_user_id,
          :time_zone,
          role_ids: [],
          user_discipline_ids: []
        )
      end

      def password_params
        params.require(:user).permit(:current_password, :password, :password_confirmation)
      end

      def search_params
        params.permit(:scope, :term, :start_at, :end_at, :match_id)
      end

      def soft_destroy_params
        params.permit(:hide_history)
      end

    end
  end
end

# frozen_string_literal: true

class UserPolicy < ApplicationPolicy

  def show?
    permission?(:index) || user == record
  end

  def authenticated?
    user.present?
  end

  def permissions?
    user.present?
  end

  def update?
    permission?(:update) || user == record
  end

  def edit?
    update?
  end

  def update_avatar?
    update?
  end

  def change_password?
    update?
  end

  def notifications?
    user == record
  end

  def authenticated_notifications?
    notifications?
  end

  def notifications_count?
    notifications?
  end

  def add_calendar_access?
    user == record
  end

  def destroy?
    return false if record.id == 1

    super
  end

  def resent_invite?
    user.superadmin?
  end

end

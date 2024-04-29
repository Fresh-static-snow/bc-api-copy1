# frozen_string_literal: true

class ApplicationPolicy

  attr_reader :user, :record, :class_name

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user

    @user   = user
    @record = record
    @class_name = case record.class.name
                  when 'Class'
                    record.name
                  when 'ActiveRecord::Relation'
                    record.klass.name
                  else
                    record.class.name
                  end
  end

  def index?
    permission?(:index)
  end

  def show?
    permission?(:show)
  end

  def create?
    permission?(:create)
  end

  def new?
    create?
  end

  def update?
    permission?(:update)
  end

  def edit?
    permission?(:edit)
  end

  def destroy?
    permission?(:destroy)
  end

  def restore?
    record.deleted? && permission?(:restore)
  end

  def soft_destroy?
    permission?(:soft_destroy)
  end

  private

  def permission?(action)
    user.permission?(class_name, action)
  end

  def superadmin?
    user&.superadmin?
  end

  class Scope

    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "must be logged in" unless user

      @user = user
      @scope = scope
    end

  end

end

# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  description :string
#  permissions :jsonb
#  title       :string           not null
#
# Indexes
#
#  index_roles_on_deleted_at  (deleted_at)
#
class RoleSerializer < Blueprinter::Base

  identifier :id

  view :common do
    fields :title, :description
  end

  view :list do
    include_view :common

    field :permissions
  end

  view :with_users do
    include_view :common

    field :user_count do |role|
      role.users.length
    end

    association :users, blueprint: UserSerializer, view: :common
  end

  view :notify do
    fields :id, :title

    field :is_deleted do |role|
      role.deleted_at.present?
    end
  end

end

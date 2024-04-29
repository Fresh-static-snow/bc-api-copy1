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
class PermissionSerializer < Blueprinter::Base

  identifier :id

  view :list do
    fields :name, :description, :target_type, :target_name, :access_type, :access_for
  end

end

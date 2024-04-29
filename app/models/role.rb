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
class Role < ApplicationRecord

  self.table_name = :roles

  acts_as_paranoid

  include Filterable
  include RoleModule::Associations
  include RoleModule::Scopes
  include RoleModule::Validations

end

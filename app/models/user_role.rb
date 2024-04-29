# frozen_string_literal: true

# == Schema Information
#
# Table name: user_roles
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  role_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_user_roles_on_deleted_at  (deleted_at)
#  index_user_roles_on_role_id     (role_id)
#  index_user_roles_on_user_id     (user_id)
#  index_user_roles_uniqueness     (user_id,role_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#  fk_rails_...  (user_id => users.id)
#
class UserRole < ApplicationRecord

  self.table_name = :user_roles

  acts_as_paranoid

  include UserRoleModule::Associations

end

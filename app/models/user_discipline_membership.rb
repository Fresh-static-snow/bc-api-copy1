# frozen_string_literal: true

# == Schema Information
#
# Table name: user_discipline_memberships
#
#  id                 :bigint           not null, primary key
#  deleted_at         :datetime
#  user_discipline_id :bigint
#  user_id            :bigint
#
# Indexes
#
#  index_user_discipline_memberships_on_deleted_at          (deleted_at)
#  index_user_discipline_memberships_on_user_discipline_id  (user_discipline_id)
#  index_user_discipline_memberships_on_user_id             (user_id)
#  index_user_discipline_memberships_uniqueness             (user_id,user_discipline_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_discipline_id => user_disciplines.id)
#  fk_rails_...  (user_id => users.id)
#
class UserDisciplineMembership < ApplicationRecord

  self.table_name = :user_discipline_memberships

  acts_as_paranoid

  after_create :change_user_display_name
  after_destroy :change_user_display_name

  include UserDisciplineMembershipModule::Associations

  private

  def change_user_display_name
    user.update_display_name_column if user.present?
  end

end

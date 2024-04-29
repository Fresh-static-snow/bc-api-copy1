# frozen_string_literal: true

# == Schema Information
#
# Table name: invitations
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  email         :string           not null
#  status        :integer          default("pending")
#  token         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  created_by_id :integer          not null
#  role_id       :integer          not null
#
# Indexes
#
#  index_invitations_on_deleted_at  (deleted_at)
#
class Invitation < ApplicationRecord

  enum status: { pending: 0, completed: 1 }

end

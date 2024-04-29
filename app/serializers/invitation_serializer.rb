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
class InvitationSerializer < Blueprinter::Base

  identifier :id

  view :common do
    fields :email
  end

end

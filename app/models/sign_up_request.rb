# frozen_string_literal: true

# == Schema Information
#
# Table name: sign_up_requests
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  status     :integer          default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_sign_up_requests_on_deleted_at  (deleted_at)
#
class SignUpRequest < ApplicationRecord

  belongs_to :user

  enum status: { pending: 0, declined: 1, approved: 2 }

end

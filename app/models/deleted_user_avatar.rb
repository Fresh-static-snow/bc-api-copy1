# frozen_string_literal: true

# == Schema Information
#
# Table name: deleted_user_avatars
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class DeletedUserAvatar < ApplicationRecord

  has_one_attached :avatar

end

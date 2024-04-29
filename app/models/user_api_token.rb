# frozen_string_literal: true

# == Schema Information
#
# Table name: user_api_tokens
#
#  id            :bigint           not null, primary key
#  access_token  :text
#  deleted_at    :datetime
#  expires_at    :datetime
#  refresh_token :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
# Indexes
#
#  index_user_api_tokens_on_deleted_at  (deleted_at)
#  index_user_api_tokens_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserApiToken < ApplicationRecord

  self.table_name = :user_api_tokens

  acts_as_paranoid

  include UserApiTokenModule::Validations
  include UserApiTokenModule::Associations

end

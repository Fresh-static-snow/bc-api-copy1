# frozen_string_literal: true

# == Schema Information
#
# Table name: user_notifications
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  description   :text
#  entity_action :string
#  entity_type   :string           not null
#  personal      :boolean
#  seen          :boolean          default(FALSE)
#  title         :string
#  created_at    :datetime
#  author_id     :integer
#  entity_id     :integer          not null
#  user_id       :integer
#
# Indexes
#
#  index_user_notifications_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class UserNotification < ApplicationRecord

  self.table_name = :user_notifications

  acts_as_paranoid

  include TimeAgoHelper
  include Filterable
  include UserNotificationModule::Associations
  include UserNotificationModule::Scopes

end

# frozen_string_literal: true

# == Schema Information
#
# Table name: account_settings
#
#  id                          :bigint           not null, primary key
#  current_user_filter_enabled :boolean          default(TRUE)
#  default_calendar_scope      :integer          default("day")
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  user_id                     :bigint           not null
#
# Indexes
#
#  index_account_settings_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class AccountSetting < ApplicationRecord

  self.table_name = :account_settings

  belongs_to :user

  enum default_calendar_scope: { day: 0, week: 1, month: 2, quarter: 3, year: 4 }

end

# frozen_string_literal: true

# == Schema Information
#
# Table name: settings
#
#  id             :bigint           not null, primary key
#  match_duration :integer          default(60)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Setting < ApplicationRecord

  validates :match_duration, numericality: { greater_than_or_equal_to: 0 }

  def self.default_match_duration
    "#{first.match_duration} minutes"
  end

end

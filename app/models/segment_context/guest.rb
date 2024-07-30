# frozen_string_literal: true

# == Schema Information
#
# Table name: guests
#
#  id         :bigint           not null, primary key
#  name       :string
#  social     :string
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  segment_id :bigint
#
module SegmentContext
  class Guest < ApplicationRecord

    include GuestModule::Associations

  end
end

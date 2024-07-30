# frozen_string_literal: true

# == Schema Information
#
# Table name: media
#
#  id          :bigint           not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  segment_id  :bigint
#
module SegmentContext
  class Media < ApplicationRecord

    include SegmentMediaModule::Associations

  end
end

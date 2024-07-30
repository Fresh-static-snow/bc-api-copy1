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
  class MediaSerializer < Blueprinter::Base

    identifier :id

    field :title
    field :description

    field :updated_at do |tournament|
      tournament.updated_at&.strftime('%H:%M %d.%m.%Y')
    end

  end
end

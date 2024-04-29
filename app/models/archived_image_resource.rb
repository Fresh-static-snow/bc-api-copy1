# frozen_string_literal: true

# == Schema Information
#
# Table name: archived_image_resources
#
#  id          :bigint           not null, primary key
#  item_column :string
#  item_type   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  item_id     :integer
#
class ArchivedImageResource < ApplicationRecord

  has_one_attached :resource

end

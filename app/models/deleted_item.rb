# frozen_string_literal: true

# == Schema Information
#
# Table name: deleted_items
#
#  id             :bigint           not null, primary key
#  cast_item_type :string
#  match_cast_ids :integer          default([]), is an Array
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  cast_item_id   :integer
#
class DeletedItem < ApplicationRecord; end

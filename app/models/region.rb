# frozen_string_literal: true

# == Schema Information
#
# Table name: regions
#
#  id         :bigint           not null, primary key
#  code       :string
#  deleted_at :datetime
#  name       :string           not null
#
# Indexes
#
#  index_regions_on_deleted_at  (deleted_at)
#
class Region < ApplicationRecord

  self.table_name = :regions

  acts_as_paranoid

  include Filterable
  include RegionModule::Associations
  include RegionModule::Scopes
  include RegionModule::Validations

end

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
class RegionSerializer < Blueprinter::Base

  identifier :id

  view :list do
    fields :name, :code
  end

end

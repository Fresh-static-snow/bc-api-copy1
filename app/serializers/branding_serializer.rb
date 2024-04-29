# frozen_string_literal: true

# == Schema Information
#
# Table name: brandings
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  visible    :boolean          default(FALSE), not null
#
# Indexes
#
#  index_brandings_on_deleted_at  (deleted_at)
#
class BrandingSerializer < Blueprinter::Base

  identifier :id

  view :list do
    fields :name, :visible
    association :logo, blueprint: ImageSerializer
    association :favicon, blueprint: ImageSerializer
  end

  view :only_deleted do
    fields :name, :visible

    field :logo do |record|
      record.archived_resources_url(:logo)
    end

    field :favicon do |record|
      record.archived_resources_url(:favicon)
    end
  end

end

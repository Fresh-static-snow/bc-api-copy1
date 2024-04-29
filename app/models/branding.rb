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
class Branding < ApplicationRecord

  self.table_name = :brandings

  acts_as_paranoid

  include Filterable
  include BrandingModule::Associations
  include BrandingModule::Scopes
  include BrandingModule::Validations

  def archived_resources_url(column)
    return '' unless ArchivedImageResource.where(item_type: self.class.name, item_id: id, item_column: column).last

    UrlGenerator.attachment_url(ArchivedImageResource.where(item_type: self.class.name, item_id: id,
                                                            item_column: column)
                                                     .last.resource)
  end

end

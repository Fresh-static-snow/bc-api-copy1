# frozen_string_literal: true

# == Schema Information
#
# Table name: cast_studios
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  keyword    :string
#  name       :string
#
# Indexes
#
#  index_cast_studios_on_deleted_at  (deleted_at)
#
module CastContext
  class Studio < ApplicationRecord

    self.table_name = :cast_studios

    acts_as_paranoid

    include Filterable
    include StudioModule::Associations
    include StudioModule::Scopes
    include StudioModule::Validations

  end
end

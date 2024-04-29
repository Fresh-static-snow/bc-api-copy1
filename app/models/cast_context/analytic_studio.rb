# frozen_string_literal: true

# == Schema Information
#
# Table name: cast_analytic_studios
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  keyword    :string
#  name       :string
#
# Indexes
#
#  index_cast_analytic_studios_on_deleted_at  (deleted_at)
#
module CastContext
  class AnalyticStudio < ApplicationRecord

    self.table_name = :cast_analytic_studios

    acts_as_paranoid

    include Filterable
    include AnalyticStudioModule::Associations
    include AnalyticStudioModule::Scopes
    include AnalyticStudioModule::Validations

  end
end

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
  class AnalyticStudioSerializer < ApplicationSerializer

    view :list do
      fields :name, :keyword
    end

  end
end

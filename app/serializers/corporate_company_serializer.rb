# frozen_string_literal: true

# == Schema Information
#
# Table name: corporate_companies
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  keyword    :string           not null
#  title      :string           not null
#
# Indexes
#
#  index_corporate_companies_on_deleted_at  (deleted_at)
#
class CorporateCompanySerializer < Blueprinter::Base

  identifier :id

  view :list do
    fields :title, :keyword

    association :cover, blueprint: ImageSerializer
  end

end

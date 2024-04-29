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
class CorporateCompany < ApplicationRecord

  self.table_name = :corporate_companies

  acts_as_paranoid

  include Filterable
  include CorporateCompanyModule::Validations
  include CorporateCompanyModule::Associations
  include CorporateCompanyModule::Scopes

end

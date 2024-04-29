# frozen_string_literal: true

# == Schema Information
#
# Table name: user_companies
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  title      :string           not null
#
# Indexes
#
#  index_user_companies_on_deleted_at  (deleted_at)
#
class UserCompany < ApplicationRecord

  self.table_name = :user_companies

  acts_as_paranoid

  include Filterable
  include UserCompanyModule::Validations
  include UserCompanyModule::Associations
  include UserCompanyModule::Scopes

end

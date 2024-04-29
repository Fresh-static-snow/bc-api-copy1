class ChangeCompaniesToCorporateCompanies < ActiveRecord::Migration[6.0]
  def change
    rename_table :companies, :corporate_companies
  end
end

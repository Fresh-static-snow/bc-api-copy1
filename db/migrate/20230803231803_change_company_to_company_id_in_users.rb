class ChangeCompanyToCompanyIdInUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :company
    add_column :users, :company_id, :integer
  end
end

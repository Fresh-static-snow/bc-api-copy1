class AddStiToMatch < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :type, :string

    add_column :matches, :title, :string
  end
end

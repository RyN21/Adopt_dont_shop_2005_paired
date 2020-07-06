class AddDetailsToShelters < ActiveRecord::Migration[5.1]
  def change
    add_column :shelters, :address, :string
    add_column :shelters, :city, :string
    add_column :shelters, :state, :string
    add_column :shelters, :zip_code, :integer
  end
end

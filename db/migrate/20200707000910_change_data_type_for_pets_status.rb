class ChangeDataTypeForPetsStatus < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :status
    add_column :pets, :status, :boolean
  end
end

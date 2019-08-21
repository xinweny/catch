class AddAddressToCats < ActiveRecord::Migration[5.2]
  def change
    add_column :cats, :address, :string
  end
end

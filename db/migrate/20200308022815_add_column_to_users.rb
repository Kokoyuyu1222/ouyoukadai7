class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :postcode, :integer
    add_column :users, :prefecture_code, :integer
    add_column :users, :address_city, :string
    add_column :users, :address_street, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end

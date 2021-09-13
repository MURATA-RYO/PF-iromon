class AddCustomerIdToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :customer_id, :integer
  end
end

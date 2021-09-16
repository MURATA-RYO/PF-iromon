class AddImageToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :image_id, :integer
  end
end

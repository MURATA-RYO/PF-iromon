class AddItemIdToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :item_id, :integer
  end
end

class AddTagNameToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :tag_name, :string
  end
end

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :guide, null: false
      t.integer :genre_id
      t.string :image_id
      t.string :tag_name, null: false
      t.timestamps
    end
  end
end
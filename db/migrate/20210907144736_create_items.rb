class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :guide
      t.integer :genre_id
      t.string :image_id

      t.timestamps
    end
  end
end
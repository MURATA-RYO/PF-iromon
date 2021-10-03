class CreateRecognitionTags < ActiveRecord::Migration[5.2]
  def change
    create_table :recognition_tags do |t|
      t.integer :item_id
      t.string :name
      t.timestamps
    end
  end
end

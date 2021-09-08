class Item < ApplicationRecord
  attachment :image
  validates :name, presence: true
  validates :guide, presence: true

end
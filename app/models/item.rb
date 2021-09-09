class Item < ApplicationRecord
  attachment :image
  validates :name, presence: true
  validates :guide, presence: true

  belongs_to :customer
  has_many :comments, dependent: :destroy

end
class Item < ApplicationRecord
  
  belongs_to :customer
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
  
  attachment :image
  validates :name, presence: true
  validates :guide, presence: true, length: { maximum: 200 }

  def self.search(search, word)
    if search == "forward_match"
      @item = Item.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @item = Item.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      @item = Item.where(name: word)
    elsif search == "partail_match"
      @item = Item.where("name LIKE?","%#{word}%")
    else
      @item = Item.all
    end  
  end
end
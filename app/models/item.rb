class Item < ApplicationRecord
  
  belongs_to :customer
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
  
  attachment :image
   validates :name, presence: true
   validates :guide, presence: true, length: { maximum: 200 }
   #validates :tag_name, presence: true
  
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete PostTag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_tag
    end
  end


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
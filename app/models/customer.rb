class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end
  
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  
  def following?(customer)
    followings.include?(customer)
  end
  
  attachment :image
  attachment :profile_image
  validates :name, presence: true
  validates :introduction, length: { maximum: 50 }
  
  def self.search(search,word)
    if search == "forward_match"
      @customer = Customer.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @customer = Customer.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      @customer = Customer.where(name: word)
    elsif search == "partial_match"
      @customer = Customer.where("name LIKE?","%#{word}%")
    else
      @customer = Customer.all
    end  
  end
end
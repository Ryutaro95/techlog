class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_follow_relations, dependent: :destroy
  has_many :followings, through: :user_follow_relations, source: :follow
  has_many :reverse_of_user_follow_relations, class_name: 'UserFollowRelation', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_user_follow_relations, source: :user
  has_many :likes, dependent: :destroy
  has_many :stocks, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, length: { maximum: 255 }
  validates :password, length: { minimum: 8 }
  validates :profile, length: { maximum: 400 }
  
  def thumbnail
    return self.image.variant(resize: '200x200')
  end

  def follow(other_user)
    unless self == other_user
      self.user_follow_relations.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.user_follow_relations.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def following_posts
    following = self.followings.map(&:id)
    Post.where(user_id: following)
  end
end

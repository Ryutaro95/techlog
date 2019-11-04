class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_one_attached :image

  def thumbnail
    return self.image.variant(resize: '200x300')
  end

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, length: { maximum: 255 }
  validates :password, length: { minimum: 8 }
  validates :profile, length: { maximum: 400 }
  

end

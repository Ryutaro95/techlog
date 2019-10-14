class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, length: { maximum: 255 }
  validates :password, length: { minimum: 8 }
  
end

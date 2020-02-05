class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :stocks, dependent: :destroy
  has_many :stocked_users, through: :stocks, source: :user
  has_many :post_tag_relations, dependent: :destroy
  has_many :tags, through: :post_tag_relations

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 10000 }

  def post_like(user)
    likes.create(user_id: user.id)
  end

  def post_unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  def like?(user)
    liked_users.include?(user)
  end

  def stock(user)
    stocks.create(user_id: user.id)
  end

  def unstock(user)
    stocks.find_by(user_id: user.id).destroy
  end

  def stocked?(user)
    stocked_users.include?(user)
  end

  # 受け取ったタグがDBに存在すれば、取得して記事と紐付ける
  # 存在しなければ、作成する
  def save_tags(tags)
    # 文字列を空白区切りで配列化
    tag_list = tags.split(/[[:blank:]]+/).select(&:present?)
    tag_list.each do |tag|
      unless find_tag = Tag.find_by(name: tag)
        begin
          self.tags.create!(name: tag)
        rescue
          nil
        end
      else
        PostTagRelation.create(post_id: self.id, tag_id: find_tag.id)
      end
    end
  end
end

class Tag < ApplicationRecord
  has_many :post_tag_relations, dependent: :destroy
  has_many :posts, through: :post_tag_relations

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }

  def self.search(search)
    return Post.page(params[:page]).per(10).order(updated_at: :desc) unless search
    Tag.where('name like ?', "%#{search.delete(" ")}%").map { |tag| tag.posts }
  end
end

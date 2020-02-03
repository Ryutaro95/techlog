class Tag < ApplicationRecord
  before_save :downcase_tag_name

  has_many :post_tag_relations, dependent: :destroy
  has_many :posts, through: :post_tag_relations

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  def self.search(search)
    return Post.page(params[:page]).per(10).order(updated_at: :desc) unless search
    Tag.where('name like ?', "%#{search.delete(" ")}%").map { |tag| tag.posts }
  end

  private

    def downcase_tag_name
      self.name.downcase!
    end
end

class Tag < ApplicationRecord
  before_save :downcase_tag_name

  has_many :post_tag_relations, dependent: :destroy
  has_many :posts, through: :post_tag_relations

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  private

    def downcase_tag_name
      self.name.downcase!
    end
end

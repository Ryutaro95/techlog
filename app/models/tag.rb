class Tag < ApplicationRecord
  before_save :downcase_tag_name

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  private

    def downcase_tag_name
      self.name.downcase!
    end
end

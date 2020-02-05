class PostTagRelation < ApplicationRecord
  belongs_to :post
  belongs_to :tag

  validates_uniqueness_of :post_id, scope: :tag_id
end

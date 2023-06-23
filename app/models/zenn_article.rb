class ZennArticle < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :likes_count
end

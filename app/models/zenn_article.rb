class ZennArticle < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :likes_count

  has_one :ogp_information, as: :informable, dependent: :destroy
end

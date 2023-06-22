class QiitaArticle < ApplicationRecord

  has_one :ogp_information, as: :informable, dependent: :destroy #ポリモーフィック関連

  validates :title, presence: true
  valedates :url, presence: true, uniqueness: true
  validates :likes_count, presence: true
end

class Template < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: true, length: { maximum: 40 }
  validates :url, presence: true
end

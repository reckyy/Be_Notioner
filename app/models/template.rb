class Template < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true
end

class Shortcut < ApplicationRecord
  validates :title, presence: true
  validates :keys, presence: true, uniqueness: true, length: { maximum: 10 }
end

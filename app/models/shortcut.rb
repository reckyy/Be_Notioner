class Shortcut < ApplicationRecord
  validates :title, presence: true
  validates :keys, presence: true, uniqueness: true
end

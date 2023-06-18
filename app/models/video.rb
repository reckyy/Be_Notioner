class Video < ApplicationRecord
  #同じ動画が保存されないように
  validates :youtube_id, uniqueness: true

  with_options presence: true do
    validates :thumbnail
    validates :title
    validates :view_count
    validates :youtube_id
  end
end
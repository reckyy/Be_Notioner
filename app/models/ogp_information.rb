class OgpInformation < ApplicationRecord
  belongs_to :informable, polymorphic: true

  with_options presence: true do
    validates :title
    validates :url
    validates :image
    validates :description
  end
end

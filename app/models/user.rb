class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { sorcery? && (new_record? || changes[:crypted_password]) }
  validates :password, confirmation: true, if: -> { sorcery? && (new_record? || changes[:crypted_password]) }
  validates :password_confirmation, presence: true, if: -> { sorcery? && (new_record? || changes[:crypted_password]) }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  validates :email, uniqueness: { scope: :login_type }, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  validates :login_type, presence: true

  has_many :templates, dependent: :destroy

  has_many :bookmarks

  enum login_type: { sorcery: 0, google: 1 }

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end

  def own?(object)
    object.user_id == id #current_userというインスタンスに対して呼び出すと、右辺のidはUserインスタンス（この場合current_user）のidを指す
  end

  def add_bookmark(bookmarkable)
    self.bookmarks.find_or_create_by(bookmarkable: bookmarkable)
  end

  def remove_bookmark(bookmarkable)
    self.bookmarks.find_by(bookmarkable: bookmarkable)&.destroy
  end

  def bookmarked?(bookmarkable)
    self.bookmarks.where(bookmarkable: bookmarkable).exists?
  end
end

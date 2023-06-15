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

  enum login_type: { sorcery: 0, google: 1 }

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end
end

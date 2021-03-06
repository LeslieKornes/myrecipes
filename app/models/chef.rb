class Chef < ApplicationRecord

  before_save { self.email = email.downcase }

  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :recipes, dependent: :destroy

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :chefname, presence: true, length: { maximum: 30 }

  validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX },
                uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true

end

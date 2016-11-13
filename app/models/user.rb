VALID_EMAIL_REGEX = /\A[\w+\-.]+@(?:[a-z\d\-]+\.)+[a-z]+\z/i
class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 64 }
  validates :email,
            presence: true,
            length: { maximum: 256 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end

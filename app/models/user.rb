class User < ApplicationRecord
  before_save {email.downcase!}

  validates :name, presence: true,
    length: {maximum: Settings.user.name_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false},
    length: {maximum: Settings.user.email_length}
  validates :password, presence: true,
    length: {minimum: Settings.user.min_length}

  has_secure_password
end

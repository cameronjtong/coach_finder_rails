class User < ApplicationRecord
  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:name, presence: true, length: {maximum: 70})
  validates(:email, presence: true, length: {maximum: 255},
             format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false})
  validates(:password, presence: true, length: {minimum: 6}, allow_nil: true)
  has_secure_password
end

class User < ApplicationRecord
  has_and_belongs_to_many :expertises
  has_many :microposts, dependent: :destroy
  attr_accessor :activation_token, :remember_token, :reset_token
  before_save {self.email = email.downcase}
  before_create :create_activation_digest
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/
  validates(:name, presence: true, length: {maximum: 70})
  validates(:email, presence: true, length: {maximum: 255},
             format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false})
  validates(:password, presence: true, length: {minimum: 6}, allow_nil: true)
  has_secure_password

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def remember
    self.remember_token = User.new_token
    self.remember_digest = User.digest(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end

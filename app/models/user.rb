class User < ApplicationRecord
  has_and_belongs_to_many :expertises
  attr_accessor :activation_token
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

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
    flash[:info] = 'Check your email to activate your account'
    redirect_to root_url
  end
end

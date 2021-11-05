class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates(:content, presence: true, length: {maximum: 300})
  validates(:user_id, presence: true)
  default_scope -> {order(created_at: :desc)}
end

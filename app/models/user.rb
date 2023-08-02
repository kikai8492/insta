class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }
  validates :email ,uniqueness: true
  before_validation { email.downcase! }
  has_secure_password
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  has_many :blogs ,dependent: :destroy
  has_many :favorite ,dependent: :destroy
end

class Blog < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :content, presence: true, length: { mininum: 1, maximum: 255 }

  belongs_to :user
  has_many :favorites ,dependent: :destroy
end

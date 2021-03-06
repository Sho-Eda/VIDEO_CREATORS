class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  # has_one_attached :image
  mount_uploader :image, ImageUploader
  # mount_uploader :video, VideoUploader

  validates :title, presence: true, length: { maximum: 50 }
end

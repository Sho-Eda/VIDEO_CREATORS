class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
  has_many :post_category
  has_many :categories, through: :post_category

  validates :title, presence: true, length: { maximum: 50 }
end

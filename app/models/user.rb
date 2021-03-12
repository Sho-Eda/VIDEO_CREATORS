class User < ApplicationRecord
  # バリデーション
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :introduction, presence: false, length: { maximum: 200 }
  has_secure_password

  mount_uploader :avatar, AvatarUploader

  has_many :posts, dependent: :destroy
  has_many :reels, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user

  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :post

  has_many :comments, dependent: :destroy

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def like(post)
    favorites.find_or_create_by(post_id: post.id) unless self == post
  end

  def unlike(post)
    favorite = favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end

  def like?(post)
    likes.include?(post)
  end

  def feed_posts
    Post.where(user_id: following_ids + [id])
  end
end

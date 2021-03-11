class Category < ApplicationRecord
  has_ancestry
  has_many :posts
  has_many :users
end

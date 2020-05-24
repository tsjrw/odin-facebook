class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id

  has_many :like_relationships, foreign_key: 'user_id'
  has_many :posts_liked, through: :like_relationships, source: :post

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2}
end

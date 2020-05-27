class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  has_many :like_relationships, foreign_key: 'user_id', dependent: :destroy
  has_many :liked_posts, through: :like_relationships, source: :post

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2}

  def unlike post
    if liked_posts.include?(post)
      liked_posts.delete(post) 
    end
  end

end

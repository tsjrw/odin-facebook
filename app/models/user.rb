class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  has_many :like_relationships, dependent: :destroy
  has_many :liked_posts, through: :like_relationships, source: :post

  has_many :sent_requests, class_name: :Friendship, foreign_key: 'friend_id', dependent: :destroy
  has_many :requested_users, through: :sent_requests, source: :user

  has_many :received_requests, class_name: :Friendship, foreign_key: 'user_id', dependent: :destroy
  has_many :friend_requests, through: :received_requests, source: :friend

  has_one_attached :avatar
  
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2}

  def unlike post
    if liked_posts.include?(post)
      liked_posts.delete(post) 
    end
  end

  def friends
    friends_ids = Friendship.where('(user_id = ? OR friend_id = ?) AND accepted = ?', id, id, true).pluck(:friend_id, :user_id)  
    friends_ids.flatten!.reject!{|f_id| f_id == id } unless friends_ids.empty?
    User.find(friends_ids)
  end

end

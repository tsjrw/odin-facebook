class Post < ApplicationRecord
  belongs_to :author, class_name: :User
  has_many :comments

  has_many :like_relationships, foreign_key: 'post_id'
  has_many :users_liking, through: :like_relationships, source: :user

  validates :content, presence: true, length: { maximum: 1000}

  def created_time
    created_at.strftime('%B %d at %l:%M %p')
  end
  
  def is_liked_by? user
    users_liking.include?(user)
  end
  
private

  def self.ordered
    Post.order(created_at: :desc)
  end

  
end

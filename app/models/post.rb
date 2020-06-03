class Post < ApplicationRecord
  belongs_to :author, class_name: :User
  has_many :comments, dependent: :destroy

  has_many :like_relationships, dependent: :destroy
  has_many :users_liking, through: :like_relationships, source: :user

  validates :content, presence: true, length: { maximum: 1000}

  def created_time
    created_at.strftime('%B %d at %l:%M %p')
  end

  def is_liked_by? user
    users_liking.include?(user)
  end
  
  def belongs_to? user
    author_id == user.id
  end  
  def comments_ordered
    comments.order(created_at: :desc)
  end
private


  def self.ordered
    Post.order(created_at: :desc)
  end

  
end

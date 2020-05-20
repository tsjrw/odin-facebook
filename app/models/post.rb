class Post < ApplicationRecord
  belongs_to :author, class_name: :User
  has_many :comments

  validates :content, presence: true, length: { maximum: 1000}

  def created_time
    created_at.strftime('%B %d at %l:%M %p')
  end
  
private

  def self.ordered
    Post.order(created_at: :desc)
  end
end

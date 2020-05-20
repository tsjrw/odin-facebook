class Comment < ApplicationRecord
  belongs_to :author, class_name: :User
  belongs_to :post
  
  validates :content, presence: true, length: { maximum: 140 }


  def created_time
    created_at.strftime('%B %d at %l:%M %p')
  end
  
private

  def self.ordered
    Comment.order(created_at: :desc)
  end
end

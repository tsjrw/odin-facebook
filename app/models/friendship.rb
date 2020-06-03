class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User

  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates_uniqueness_of :user_id, scope: :friend_id
  validate :cannot_add_self, :cannot_repeat_relation

  private
    def cannot_add_self
      if user_id == friend_id
        errors.add(:friend_id, "You cannot add your self as a friend.")
      end
    end
    def cannot_repeat_relation
      unless Friendship.where('user_id = ? AND friend_id = ?', friend_id, user_id).empty?
        errors.add(:user_id, "The request already exists")
      end
    end
end

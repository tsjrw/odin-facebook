module ApplicationHelper

    def pending_users_id_requests
        Friendship.where('user_id = ? AND accepted = ?', current_user.id, false).pluck(:friend_id)
    end
    
    def requests_number
        pending_users_id_requests.count
    end

    def friends_posts
        friend_ids = current_user.friends.pluck(:id) unless current_user.nil?
        Post.where(author_id: friend_ids).ordered
    end

end

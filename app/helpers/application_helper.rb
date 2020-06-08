module ApplicationHelper

    def pending_users_id_requests
        Friendship.where('user_id = ? AND accepted = ?', current_user.id, false).pluck(:friend_id)
    end

    def non_friend_users
        users = User.where.not('id = ?', current_user.id)
        users.select do |user|
            !(current_user.friend_requests.include?(user) ||  current_user.requested_users.include?(user))
        end
    end
    
    def requests_number
        pending_users_id_requests.count
    end

    def friends_posts
        friend_ids = current_user.friends.pluck(:id) unless current_user.nil?
        Post.where(author_id: friend_ids).ordered
    end

    def avatar_icon(user, size)
        image_tag url_for(user.avatar), size: "#{size}x#{size}", class: 'profile_image' if user.avatar.attached?
    end
end

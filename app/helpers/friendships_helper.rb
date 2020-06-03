module FriendshipsHelper
    def received_request(friend_id)
        Friendship.where('user_id = ? AND friend_id = ? ',current_user.id, friend_id)
    end
    
    def friendship_request(friend_id)
        request = received_request(friend_id)
        if request.empty?
            request = Friendship.where('user_id = ? AND friend_id = ? ', friend_id, current_user.id)
        end
        request
    end
end

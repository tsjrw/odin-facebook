class FriendshipsController < ApplicationController
    include FriendshipsHelper

    before_action :authenticate_user!

    def create 
        friend = User.find(params[:user_id])
        unless current_user.friend_requests.include?(friend) && friend.id == current_user.id
            if current_user.requested_users << friend
                flash[:success] = 'Request succesfully sent'
                redirect_to request.referrer
            end
        end
    end

    def update
        if received_request(params[:user_id]).update(accepted: true)
            flash[:success] = 'Friend succesfully added'
            redirect_to request.referrer
        end
    end

    def destroy
        other_user = User.find(params[:user_id])
        unless current_user.friends.include?(other_user)
            message = 'Request succesfully declined'
        else
            message = 'Friend succesfully removed' 
        end
        if Friendship.delete(friendship_request(other_user.id))
            flash[:success] = message
            redirect_to request.referrer
        end
    end


end

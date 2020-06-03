class UsersController < ApplicationController
    before_action :authenticate_user!
    def index 
        @users = User.where.not('id = ?', current_user.id)
    end
    def pending_requests
        puts pending_users_id_requests
        @users = User.find(pending_users_id_requests)
    end
    def friends
        @users = current_user.friends
    end
    def show 
        @user = User.find(params[:id])
        @posts = @user.posts.ordered
    end
end

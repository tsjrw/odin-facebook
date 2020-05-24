class LikeRelationshipsController < ApplicationController
    before_action :authenticate_user!
    def create
        post = Post.find(params[:post_id])
        unless post.is_liked_by?(current_user)
            current_user.posts_liked << post
            redirection(post)
        end
    end

    def destroy
        post = Post.find(params[:post_id])
        post.users_liking.delete(current_user)
        redirection(post)
    end

end

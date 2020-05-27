class LikeRelationshipsController < ApplicationController
    before_action :authenticate_user!
    def create
        post = Post.find(params[:post_id])
        unless post.is_liked_by?(current_user)
            current_user.liked_posts << post
            redirection(post)
        end
    end

    def destroy
        post = Post.find(params[:post_id])
        if post.is_liked_by?(current_user)
            current_user.unlike(post)
            redirection(post)
        end
    end

end

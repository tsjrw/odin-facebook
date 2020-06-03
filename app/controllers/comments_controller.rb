class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(content: comment_params[:content], 
                                            post_id: params[:post_id])
    if @comment.save
      redirect_to request.referrer
    else
      flash.now[:danger] = "Some errors have occurred writing the comment. Try again."
      render 'new'
    end
  end 

  def destroy 
    comment = Comment.find(params[:id])
    if comment.belongs_to?(current_user)
      post = comment.post
      comment.delete
      redirect_to request.referrer
    end
  end

  private 
    def comment_params
      params.require(:comment).permit(:content)
    end
end

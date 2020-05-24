class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(content: comment_params[:content], 
                                            post_id: params[:post_id])

    if @comment.save
      if home?
        redirect_to root_path
      else
        redirect_to @comment.post.author
      end
    else
      flash.now[:danger] = "Some errors have occurred writing the comment. Try again."
      render 'new'
    end
  end 

  private 
    def comment_params
      params.require(:comment).permit(:content)
    end
end

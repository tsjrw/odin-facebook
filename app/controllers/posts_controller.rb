class PostsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post = Post.find(params[:id])
  end

  def new
    
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "The post was successfully created!"
      redirect_to current_user
    else
      flash.now[:danger] = "The post has not been created. Try again."
      render 'new'
    end
  end


  private

    def post_params 
      params.require(:post).permit(:content)
    end

end

class StaticPagesController < ApplicationController
  def home
    @posts = Post.ordered
  end
end

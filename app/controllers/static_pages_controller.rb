class StaticPagesController < ApplicationController
  def home
    @posts = friends_posts
  end
end

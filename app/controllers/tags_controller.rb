class TagsController < ApplicationController
  
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.includes(:user).order(created_at: :desc)
  end
end

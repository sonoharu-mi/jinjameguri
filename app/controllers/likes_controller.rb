class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.create(post_id: @post.id)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)&.destroy
    
    respond_to do |format|
      format.js
    end
  end
end

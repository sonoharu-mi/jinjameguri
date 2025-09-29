class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    @posts = Post.all
    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:image, :shirine_name, :body)
  end
end

class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@post.id)
    else
      @posts = Post.all
      flash[:alert] = "投稿に失敗しました"
      redirect_to :index
    end
  end

  def index
    @posts = Post.all
    @users = User.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:image, :shirine_name, :body, :address, :parking, :shirine_stamp, :seasonal_stamp)
  end
end

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
      flash[:alert] = "投稿に失敗しました"
      render :new
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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集に成功しました。"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "編集に失敗しました"
      render :index
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:image, :shirine_name, :body, :address, :parking, :shirine_stamp, :seasonal_stamp)
  end
end

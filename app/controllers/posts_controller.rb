class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matcing_login_user, only: [:edit, :update]
  before_action :block_guest_user, only: [:new, :create, :edit, :update]
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(/[[:blank:],、]+/).uniq

    if @post.save
      tag_list.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        @post.tags << tag
      end
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@post.id)
    else
      @user = current_user.id
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def index
    respond_to do |format|
      format.html do
        @posts = Post.order(created_at: :desc).page(params[:page])
      end
      format.json do
        @posts = Post.includes(:user).order(created_at: :desc)
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(/[[:blank:],、]+/).uniq if params[:post][:tag_name].present?
    
    if @post.update(post_params)
      if tag_list
        @post.tags.clear
        tag_list.each do |tag_name|
          tag = Tag.find_or_create_by(name: tag_name)
          @post.tags << tag
        end
      end
      flash[:notice] = "編集に成功しました。"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit( :shirine_name, :body, :address, :latitude, :longitude, :parking, :shirine_stamp, :seasonal_stamp, :image)
  end

  def is_matcing_login_user
    @post = Post.find(params[:id])
    @user = @post.user
    unless @user.id == current_user.id
      redirect_to posts_path
    end
  end
end

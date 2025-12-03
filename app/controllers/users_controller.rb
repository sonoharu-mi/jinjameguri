class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def mypage
    @mypage = User.find(current_user.id)
    @posts = @mypage.posts
    @like_posts = Post.joins(:likes).where(likes: { user_id: current_user.id})
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールの編集に成功しました。"
      redirect_to mypage_path
    else
      flash[:error] = "プロフィールの編集に失敗しました"
      render :edit
    end
  end

  def destroy
    user = User.find(current_user.id)
    user.destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matcing_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def ensure_guest_user
    @mypage = User.find(params[:id])
    if @mypage.guest_user?
      redirect_to mypage_path(current_user), notice: "ゲストユーザーはプロフィール編集できません。"
    end
  end
end

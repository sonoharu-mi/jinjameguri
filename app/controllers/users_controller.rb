class UsersController < ApplicationController
  def mypage
    @mypage = User.find(current_user.id)
    @posts = @mypage.posts
    
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
      flash[:alert] = "プロフィールの編集に失敗しました"
      render :edit
    end
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
end

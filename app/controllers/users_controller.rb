class UsersController < ApplicationController
  def mypage
    @mypage = User.find(current_user.id)
    @posts = Post.all
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

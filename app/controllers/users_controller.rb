class UsersController < ApplicationController
  def mypage
    @mypage = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @posts = 
  end

  def edit
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

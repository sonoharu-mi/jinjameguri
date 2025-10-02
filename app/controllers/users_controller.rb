class UsersController < ApplicationController
  def mypage
    @mypage = User.find(current_user.id)
    @post_new = Post.new
    @post = Post.find(current_user.id)
  end

  def show
    
  end

  def edit
    @user = User.find(current_user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

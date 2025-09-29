class UsersController < ApplicationController
  def mypage
    @mypage = User.find(current_user.id)
    
  end

  def show
  end

  def edit
  end
end

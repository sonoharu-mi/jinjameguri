class UsersController < ApplicationController
  def mypage
    @mypage = User.show
    
  end

  def show
  end

  def edit
  end
end

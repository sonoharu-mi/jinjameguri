class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def index
    @users = User.all.order(created_at: :desc).page(params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'ユーザーを退会させました'
  end
end

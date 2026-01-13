class Admin::GroupsController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def index
    @groups = Group.all.order(created_at: :desc).page(params[:page])
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path, notice: 'グループを削除しました'
  end
end

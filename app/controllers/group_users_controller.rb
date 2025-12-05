class GroupUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    group = Group.find(params[:group_id])
    group_user = group.group_users.new(user: current_user, status: :pending)
    if group_user.save
      flash[:notice] = "参加申請を送りました"
    else
      flash[:error] = "すでに申請済みです"
    end
    redirect_to group_path(group)
  end

  def approve
    group_user = GroupUser.find(params[:id])
    group_user.update(status: :approved)
    redirect_to request.referer, notice: "承認しました"
  end

  def reject
    group_user = GroupUser.find(params[:id])
    group_user.update(status: :rejected)
    redirect_to request.referer, notice: "拒否しました"
  end

  def leave
    group_user = GroupUser.find(params[:id])

    if group_user.user == current_user
      group_user.destroy
      redirect_to groups_path, notice: "グループを退会しました。"
    else
      redirect_to group_user.group, alert: "自分以外を退会させることはできません。"
    end
  end
end

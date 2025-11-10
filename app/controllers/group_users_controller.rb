class GroupUsersController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    group_user = group.group_users.new(user_id: current_user.id, status: :pending)
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

  def destroy
    group_user = GroupUser.find_by(group_id: params[:group_id], user_id: current_user.id)
    group_user.destroy if group_user
    redirect_to groups_path, notice: "グループを脱退しました"
  end
end

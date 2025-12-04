class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner, only: [:edit, :update, :destroy]
  
  def create
    @group = current_user.owned_groups.build(group_params)
    @group.users << current_user

    if @group.save
      redirect_to @group, notice: "グループを作成しました"
    else
      @group = Group.all
      flash.now[:error] = "グループの作成に失敗しました"
      render :index
    end
  end

  def index
    @groups = Group.all
    @group = Group.new
  end

  def show
    @menbers = @group.users
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "グループの編集に成功しました。"
      redirect_to @group
    else
      flash[:error] = "グループの編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def authorize_owner
    unless @group.owner == current_user
      redirect_to @group, alert: "この操作を行う権限がありません。"
    end
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

end

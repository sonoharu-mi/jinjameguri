class GroupsController < ApplicationController
  before_action :authenticate_user!

  
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
  end

  def edit
  end

  def destroy
  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction)
  end

end

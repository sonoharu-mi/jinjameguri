class GroupsController < ApplicationController
  before_action :authenticate_user!

  def new
    
  end
  
  def create
  end

  def index
    @groups = Group.all
    @group = Groupe.new
  end

  def show
  end

  def edit
  end

  def destroy
  end


end

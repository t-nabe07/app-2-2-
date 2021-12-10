class GroupsController < ApplicationController

  def new
    @group = Group.new
    @group.users << current_user #意味は？
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path(group)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def index
    @groups = Group.all
  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

end

class GroupsController < ApplicationController

  def new
    @group = Group.new
    @group.users << current_user #意味は？
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups,notice: 'グループを作成しました'
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
  end

  private
  def group_params
    params.require(:group).permit(:name, :user_id)
  end

end

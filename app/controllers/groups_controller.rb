class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to group_path(@group)
    else
      @group = Group.new
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    if @group.owner_id != current_user.id
      redirect_to groups_path
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def index
    @groups = Group.all
  end

  def destroy  #仮作成　最終的になくす
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  #投稿者だけが編集・削除ができる記述 ここが効いてないみたいでconntrollerでアクセス不可
  def ensure_correct_user
    @group = Group.find(params[:id])
    if @group.owner_id != current_user.id
      redirect_to groups_path
    end
  end

end

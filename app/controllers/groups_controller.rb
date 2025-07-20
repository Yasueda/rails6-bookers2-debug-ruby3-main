class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit, :destroy, :notice]
  def index
    @groups = Group.all
    @book = Book.new
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "You have updated group successfully."
    else
      redirect_to groups_path
    end
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      current_user.user_groups.create(group_id: @group.id)
      redirect_to group_path(@group), notice: "You have created group successfully."
    else
      render :new
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path
  end

  def join
    @group = Group.find(params[:id])
    UserGroup.create(user_id: current_user.id, group_id: @group.id)
    redirect_to group_path(@group)
  end

  def leave
    @group = Group.find(params[:id])
    user_group = UserGroup.find_by(user_id: current_user.id, group_id: @group.id)
    user_group.destroy
    redirect_to group_path(@group)
  end

  def notice
    # Notice an Event用の仮リンクとアクション
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    unless Group.find(params[:id]).owner_id == current_user.id
      redirect_to groups_path
    end
  end

end

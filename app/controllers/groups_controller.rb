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
      @groups = Group.all
      @book = Book.new
      render :index
    end
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      current_user.user_groups.create(group_id: @group.id)
      redirect_to group_path(@group), notice: "You have created group successfully."
    else
      @groupes = Group.all
      @book = Book.new
      render 'index'
    end
  end

  def destroy
  end

  def join
    @book = Book.new
    @group = Group.find(params[:id])
    user_group = UserGroup.find_by(user_id: current_user.id, group_id: @group.id)
    if user_group.nil?
      UserGroup.create(user_id: current_user.id, group_id: @group.id)
      redirect_to group_path(@group)
    else
      render :index
    end
  end

  def leave
    @group = Group.find(params[:id])
    user_group = UserGroup.find_by(user_id: current_user.id, group_id: @group.id)
    user_group.destroy

    @book = Book.new
    redirect_to group_path(@group)
  end

  def notice
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

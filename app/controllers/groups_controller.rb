class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]
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
      render :edit
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
      render 'index'
    end
  end

  def destroy
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

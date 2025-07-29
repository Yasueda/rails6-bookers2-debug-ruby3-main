class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]
  before_action :ensure_guest_user, only: [:edit]

  def show
    # 個人ページの本を並び変えるならココ
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def datebooks
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @date = params[:date].to_date
    @datebooks = @books.date_books(@date)
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def followers
    user = User.find(params[:id])
    @users = user.followed_user
  end

  def followeds
    user = User.find(params[:id])
    @users = user.follower_user
  end


  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), notice: "this user cannot access"
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "Guest user cannot access"
    end
  end
end

class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @book_comment = BookComment.new

    # 24時間内に同名アクセスしたかどうか
    time = Time.zone.now
    unless ShowCount.where('created_at >= ?', time.yesterday).find_by(user_id: current_user.id, book_id: @book.id)
      current_user.show_counts.create(book_id: @book.id)
    end
  end

  def index
    # time = Time.zone.now
    # @books = Book.all.populer_last(time.last_week)
    @book = Book.new
    if params[:how_order] == "new_order"
      @books = Book.new_order
    elsif params[:how_order] == "old_order"
      @books = Book.old_order
    elsif params[:how_order] == "star_order"
      @books = Book.star_order
    elsif params[:how_order] == "favorite_order"
      time = Time.zone.now
      @books = Book.all.populer_last(time.last_week)
    else
      @books = Book.all
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user

    if @book.save
      # タグの作成
      @tags = params[:book][:tag].split(',')
      @tags.each do |tag|
        tag = Tag.find_or_create_by(name: tag.gsub(/　/," ").strip)
        tag.book_tags.create(book_id: @book.id)
      end

      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star)
  end

  def ensure_correct_user
    @user = Book.find(params[:id]).user
    unless @user == current_user
      redirect_to books_path
    end
  end
end

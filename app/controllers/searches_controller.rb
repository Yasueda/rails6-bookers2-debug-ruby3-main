class SearchesController < ApplicationController
  def search
    if params[:table] == 'User'
      @table = User.where("name = ?", params[:word])
    elsif params[:table] == 'Book'
      @table = Book.where("title = ?", params[:word])
    end
  end
end

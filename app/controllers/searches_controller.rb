class SearchesController < ApplicationController
  def search
    if params[:table] == User.name
      @searches = User.all
      search_cell = :name
    elsif params[:table] == Book.name
      @searches = Book.all
      search_cell = :title
    else
      @searches = []
    end

    if params[:how] == "exact_match"
      @searches = @searches.where("#{search_cell} LIKE?", @searches.sanitize_sql_like(params[:word]))
    elsif params[:how] == "forward_match"
      @searches = @searches.where("#{search_cell} LIKE?", @searches.sanitize_sql_like(params[:word]) + "%")
    elsif params[:how] == "backward_match"
      @searches = @searches.where("#{search_cell} LIKE?", "%" + @searches.sanitize_sql_like(params[:word]))
    elsif params[:how] == "partial_match"
      @searches = @searches.where("#{search_cell} LIKE?", "%" + @searches.sanitize_sql_like(params[:word]) + "%")
    end
  end
end
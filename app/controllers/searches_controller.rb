class SearchesController < ApplicationController
  def search
    if params[:word].empty?
      @searches = []
    else
      if params[:table] == User.name
        @searches = User.all
        search_cell = :name
      elsif params[:table] == Book.name
        @searches = Book.all
        search_cell = :title
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

  def search_tag
    if params[:tag_word].empty?
      @searches = []
    else
      tag = Tag.find_by(name: params[:tag_word])
      unless tag.nil?
        @searches = tag.books
      else
        @searches = []
      end
    end
  end

end
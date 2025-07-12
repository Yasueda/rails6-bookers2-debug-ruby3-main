class HomesController < ApplicationController
  def top
    if user_signed_in?
      render :about
    end
  end
  
  def about
  end
end

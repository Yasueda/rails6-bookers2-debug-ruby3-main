class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    relationship = current_user.followeds.new(follower_id: user.id)
    relationship.save
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    relationship = current_user.followeds.find_by(follower_id: user.id)
    relationship.destroy
    redirect_to request.referer
  end
end

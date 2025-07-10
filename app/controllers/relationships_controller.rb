class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:followed_id])
    relation = current_user.relation.new(followed_id: user.id)
    relation.save
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:followed_id])
    relation = current_user.relation.find_by(followed_id: user.id)
    relation.destroy
    redirect_to request.referer
  end
end

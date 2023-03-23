class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    # user = User.find(params[:follow_id])
    current_user.follow(params[:follow_id])
    redirect_to request.referer
  end

  def destroy
    Relationship.find_by(follower_id: current_user.id, followed_id: params[:id]).destroy
    redirect_to request.referer
  end

end

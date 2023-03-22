class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    other_user = User.find(params[:user_id])
    user.active_relationships.create(followed_id: other_user.id)
    user.passive_relationships.create(follower_id: current_user.id)
    redirect_to request.referer
  end

  def destroy
    other_user = Relationship.find(params[:followed_id])
    user.active_relationships.find_by(followed_id: other_user.id).destroy
    redirect_to request.referer
  end

end

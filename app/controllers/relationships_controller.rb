class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.active_relationships.create(followed_id: params[:id])
    redirect_to request.referer
  end

  def destroy
    current_user.active_relationships.find_by(followed_id: params[:id]).destroy
    redirect_to request.referer
  end
end

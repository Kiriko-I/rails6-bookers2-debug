class RoomsController < ApplicationController

  before_action :authenticate_user!

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
      @another_entry = @entries.where.not(user_id: current_user.id).first
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    room = Room.create
    Entry.create(user_id: current_user.id, room_id: room.id)
    Entry.create(user_id: params[:entry][:user_id], room_id: room.id)
    redirect_to "/rooms/#{room.id}"
  end

end

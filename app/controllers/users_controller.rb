class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    
    @relationship = current_user.active_relationships.find_by(followed_id: @user.id)
    @set_relationship = current_user.active_relationships.new
    
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |current|
        @user_entry.each do |user|
          if current.room_id == user.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      if @is_room != true
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def index
    @users = User.all
    @book = Book.new
    @relationship = current_user.active_relationships.find_by(followed_id: current_user.id)
    @set_relationship = current_user.active_relationships.new
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
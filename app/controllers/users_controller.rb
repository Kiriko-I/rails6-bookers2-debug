class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @relationship = current_user.active_relationships.find_by(followed_id: @user.id)
    @set_relationship = current_user.active_relationships.new
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

  def followeds
    @followeds = User.find(params[:id]).followed_users
  end

  def followers
    @followers = User.find(params[:id]).follower_users
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
class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @book_comment = BookComment.new
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @books.user_id)
    unless @books.user_id == current_user.id
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
    current_user.book_view_counts.create(book_id: @books.id)
  end

  def index
    @book = Book.new
    if params[:sort]
      @books = Book.all.order(params[:sort])
    else
      to = Time.current.at_end_of_day
      from = (to - 6.day).at_beginning_of_day
      @books = Book.all.sort_by {|x|
        x.favorites.where(created_at: from...to).count
        }.reverse
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      @book = Book.find(params[:id])
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :tag, :evaluation)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

end

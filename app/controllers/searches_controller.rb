class SearchesController < ApplicationController
  def search
    @word = params[:search_word]
    word = params[:search_word]
    data = params[:search_data]
    method = params[:search_method]
    if data == "users_match"
      @data = "Users"
      if method == "forward_match"
        @posts = User.where("name LIKE?","#{word}%")
      elsif method == "backward_match"
        @posts = User.where("name LIKE?","%#{word}")
      elsif method == "perfect_match"
        @posts = User.where("#{word}")
      elsif method == "partial_match"
        @posts = User.where("name LIKE?","%#{word}%")
      else
        @posts = User.all
      end
    elsif data == "books_match"
      @data = "Books"
      if method == "forward_match"
        @posts = Book.where("title LIKE?","#{word}%")
      elsif method == "backward_match"
        @posts = Book.where("title LIKE?","%#{word}")
      elsif method == "perfect_match"
        @posts = Book.where("#{word}")
      elsif method == "partial_match"
        @posts = Book.where("title LIKE?","%#{word}%")
      else
        @posts = Book.all
      end
    end
  end
end

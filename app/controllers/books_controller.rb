class BooksController < ApplicationController
  before_action :authenticate_user!

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new

  end

  def index
    @books = Book.all
    @book_new = Book.new
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id

    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      @books = Book.all
      render ("books/index")
    end
  end

  def edit
    @book = Book.find(params[:id])

    if @book.user != current_user
      redirect_to books_path
    end

  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render ("books/edit")
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end

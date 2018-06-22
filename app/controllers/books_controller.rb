class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
  	@books = Book.all
    @user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      redirect_to books_path
    end
  end

  def show
  	@book = Book.find(params[:id])
    @user = @book.user
    @booknew = Book.new
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user_id == current_user.id
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = 'Book was successfully updated.'
  	  redirect_to book_path(@book.id)
    else
      redirect_to book_path(@book.id)
    end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
    flash[:success] = 'Book was successfully destroyed.'
  	redirect_to books_path
  end

  private
    def book_params
   	  params.require(:book).permit(:title, :opinion , :user_id)
    end

    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end

end

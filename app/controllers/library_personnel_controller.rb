class LibraryPersonnelController < ApplicationController
endclass LibraryPersonnelController < LibraryUsersController
before_action :authorize_library_personnel

def dashboard
  @books = Book.all
  @users = LibraryUser.all
end

def manage_books
  @books = Book.all
end

def manage_users
  @users = LibraryUser.all
end

def add_book
  @book = Book.new(book_params)
  if @book.save
    redirect_to manage_books_path, notice: "Book added successfully."
  else
    render :manage_books, alert: "Failed to add book."
  end
end

def remove_book
  book = Book.find(params[:id])
  book.destroy
  redirect_to manage_books_path, notice: "Book removed successfully."
end

private

def authorize_library_personnel
  unless current_user.is_a?(LibraryPersonnel)
    redirect_to root_path, alert: "Access Denied: You are not Library Personnel"
  end
end

def book_params
  params.require(:book).permit(:title, :author, :isbn, :published_date, :available)
end
end

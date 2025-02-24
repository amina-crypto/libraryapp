class AnonymousUsersController < ApplicationController
  def home
    @latest_books = Book.last(10) # Fetch latest books
  end

  def search
    @resources = if params[:query].present?
                   Book.where("title LIKE ? OR author LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
                   []
    end
  end

  def show
    @resource = Book.find(params[:id]) # Assuming Book model exists
  end
end

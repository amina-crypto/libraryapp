class LibraryUsersController < AnonymousUsersController
  before_action :authenticate_user!
  before_action :authorize_library_user
  respond_to :json, :xml

  def index
    @resources = if params[:category].present?
      LibraryResource.where(category_id: params[:category])
    else
      LibraryResource.all
    end
    respond_with @resources
  end
  def search
    @resources = LibraryResource.where("title LIKE ?", "%#{params[:query]}%")
    respond_with @resources
  end
end

  def dashboard
    @borrowed_books = current_user.loans
  end

  def profile
    @user = current_user
  end

  def borrowed_books
    @borrowed_books = current_user.loans
  end

  def reserve
    book = Book.find(params[:id])
    if book.available?
      Reservation.create(user: current_user, book: book)
      redirect_to borrowed_books_path, notice: "Book successfully reserved."
    else
      redirect_to resource_details_path(book), alert: "Book is not available."
    end
  end

  private

  def authorize_library_user
    unless current_user.is_a?(LibraryUser)
      redirect_to root_path, alert: "Access Denied: You are not a Library User"
    end
  end

class AnonymousUsersController < ApplicationController
  # Support JSON/XML format responses
  respond_to :html, :json, :xml
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found


  def home
    @latest_books = Book.last(10)
    @latest_journals = Journal.last(10)
  end

  def search
    if params[:query].present? || params[:category].present?
      @books = Book.includes(:category)
                   .where("title LIKE ? OR author LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
                   .where(category: params[:category]) if params[:category].present?
      @journals = Journal.includes(:category)
                        .where("title LIKE ?", "%#{params[:query]}%")
                        .where(category: params[:category]) if params[:category].present?
    else
      @books = []
      @journals = []
    end

    respond_with(@books, @journals)
  end

  def show
    @resource = LibraryResource.find(params[:id])
    @availability = @resource.check_availability # Need to implement this method
    respond_with(@resource)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: "Account created successfully! Please login."
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :contact_address)
  end
  def resource_not_found
    flash[:alert] = "The requested resource could not be found."
    redirect_to root_path
  end
end

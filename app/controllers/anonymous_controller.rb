class AnonymousController < ApplicationController
  # Explicitly skip any authentication
  layout "anonymous"

  def index
    @categories = Category.all
    @featured_books = Book.includes(:categories)
                         .order(created_at: :desc)
                         .limit(5)

    @featured_journals = Journal.includes(:categories)
                               .order(created_at: :desc)
                               .limit(5)

    if params[:category_id].present?
      category_id = params[:category_id]
      @featured_books = @featured_books.joins(:categorizations)
                                     .where(categorizations: { category_id: category_id })
      @featured_journals = @featured_journals.joins(:categorizations)
                                           .where(categorizations: { category_id: category_id })
    end

    if params[:query].present?
      query = params[:query].downcase
      @featured_books = @featured_books.where("LOWER(title) LIKE ? OR LOWER(description) LIKE ?",
                                            "%#{query}%", "%#{query}%")
      @featured_journals = @featured_journals.where("LOWER(title) LIKE ? OR LOWER(description) LIKE ?",
                                                  "%#{query}%", "%#{query}%")
    end
  rescue StandardError => e
    Rails.logger.error("Error loading resources: #{e.message}")
    flash.now[:alert] = "Unable to load library resources. Please try again later."
    @featured_books = []
    @featured_journals = []
    @categories = []
  end

  def search
    @categories = Category.all
    @query = params[:query]
    @category_id = params[:category_id]

    @featured_books = Book.includes(:categories)
    @featured_journals = Journal.includes(:categories)

    if @category_id.present?
      @featured_books = @featured_books.joins(:categorizations)
                                     .where(categorizations: { category_id: @category_id })
      @featured_journals = @featured_journals.joins(:categorizations)
                                           .where(categorizations: { category_id: @category_id })
    end

    if @query.present?
      @featured_books = @featured_books.where("LOWER(title) LIKE ? OR LOWER(description) LIKE ?",
                                            "%#{@query.downcase}%", "%#{@query.downcase}%")
      @featured_journals = @featured_journals.where("LOWER(title) LIKE ? OR LOWER(description) LIKE ?",
                                                  "%#{@query.downcase}%", "%#{@query.downcase}%")
    end

    render :index
  end

  def show_resource
    @resource = LibraryResource.includes(:categories, :reservations, :loans)
                              .find(params[:id])

    @is_available = @resource.available?
    @current_loan = @resource.current_loan
    @current_reservation = @resource.current_reservation
    @categories = @resource.categories # Explicitly load categories

    # Calculate return date if loaned
    @return_date = @current_loan&.due_date if @current_loan

    # Check if user is logged in (assuming you're using Devise)
    @user_signed_in = user_signed_in? if defined?(user_signed_in?)
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Resource not found"
    redirect_to library_path
  end

  private

  def search_params
    params.permit(:query, :type, :category_id, :language)
  end

  def resource_params
    params.require(:library_resource).permit(:title, :publish_year, :language, :publisher, :description, category_ids: [])
  end
end

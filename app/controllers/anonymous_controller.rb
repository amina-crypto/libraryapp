class AnonymousController < ApplicationController
  # Explicitly skip any authentication
  layout 'anonymous'

  def index
    @featured_books = Book.includes(:category)
                         .available
                         .order(created_at: :desc)
                         .limit(5)
    
    @featured_journals = Journal.includes(:category)
                               .available
                               .order(created_at: :desc)
                               .limit(5)
                               
    @categories = Category.all
  rescue StandardError => e
    @featured_books = []
    @featured_journals = []
    @categories = []
    flash.now[:alert] = "Unable to load library resources"
  end

  def search
    @query = params[:query]
    @type = params[:type]
    
    base_query = Resource.includes(:category)
                        .search_by_term(@query)
                        .by_category(params[:category_id])
                        .by_language(params[:language])
    
    @books = base_query.where(type: 'Book').limit(5)
    @journals = base_query.where(type: 'Journal').limit(5)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show_resource
    @resource = Resource.find(params[:id])
    
    if !@resource.available? && !user_signed_in?
      store_location_for(:user, resource_path(@resource))
      flash[:notice] = "Please log in to reserve this resource"
      redirect_to new_user_session_path
    end
  end

  private

  def search_params
    params.permit(:query, :type, :category_id, :language)
  end
end 
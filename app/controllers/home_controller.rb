class HomeController < ApplicationController
  # Explicitly skip any authentication
  def index
    render layout: false # This will use only the view without any layout
  end
end

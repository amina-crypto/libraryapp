class ApplicationController < ActionController::Base
  # Remove everything related to authentication from here
  protect_from_forgery with: :exception

  # Add a method to check if authentication is required
  def authenticate_user_if_needed!
    if requires_authentication?
      authenticate_user!
    end
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # Devise handles `current_user`, so we remove the manual implementation
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname, :contact_address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :surname, :contact_address])
  end

  def requires_authentication?
    controller_path.start_with?('personnel/') || 
    controller_path.start_with?('user/') ||
    controller_name == 'reservations'
  end

  # Add the Devise helper methods
  include Devise::Controllers::Helpers
end

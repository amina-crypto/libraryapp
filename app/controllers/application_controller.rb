class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  # Devise handles `current_user`, so we remove the manual implementation
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname, :contact_address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :surname, :contact_address])
  end
end

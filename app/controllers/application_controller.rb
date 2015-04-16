class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_character

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter -> { flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice] }

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).append [:name]
  end

  def current_character
    @current_character ||= Character.find(current_user.last_used_character)
  end
end

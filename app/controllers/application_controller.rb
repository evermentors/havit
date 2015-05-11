class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_character

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter -> { flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice] }

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).append [:name]
    devise_parameter_sanitizer.for(:account_update).append [:name]
    # devise_parameter_sanitizer.for(:account_update).append [:name, :avatar]
  end

  def current_character
    if session[:last_used_character_id].nil?
      session[:last_used_character_id] = current_user.last_used_character
    end
    @current_character = Character.find(session[:last_used_character_id])
  end

  def universe
    @universe ||= Group.find_by_name('Universe')
  end

  def url (character=current_character)
    if character.group == universe
      root_url
    else
      group_url(character.group)
    end
  end
end

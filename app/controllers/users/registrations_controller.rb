class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  after_filter :clear_flashes

  protected
  def clear_flashes
  	flash.discard
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :full_name) }
  end
end
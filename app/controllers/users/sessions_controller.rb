class Users::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def new
  	super
  end

  def create
  	self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    if params[:user][:agreed_to_waiver]
  		current_user.update_attributes(:agreed_to_waiver => params[:user][:agreed_to_waiver])
  	end
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def destroy
    super
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :agreed_to_waiver])
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #include SessionsHelper

  #check_authorization

  before_filter :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
  	departments_path  #change later
	end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end

  #For cancan permitted attr. bug
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password) }
    end
end

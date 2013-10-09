class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name,
  		:email, :current_password, :password, :password_confirmation) }
  end

  # def redirect_to(options = {}, response_status = {})
  # 	if request.xhr?
  # 		render(:update) { |page| page.redirect_to(options) }
  # 	else
  # 		super(options, response_status)
  # 	end
  # end
end

class ApplicationController < ActionController::Base
  http_basic_authenticate_with(
    name: ENV.fetch("SITE_USERNAME", "styley"),
    password: ENV.fetch("SITE_PASSWORD", "admin")
  )

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, { :if => :devise_controller? }

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :style_description])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :style_description])
  end
end

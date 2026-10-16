class ApplicationController < ActionController::Base
  if Rails.env.production?
    http_basic_authenticate_with(
      name: ENV.fetch("SITE_USERNAME", "styley"),
      password: ENV.fetch("SITE_PASSWORD", "admin")
    )
  end

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, { :if => :devise_controller? }

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :style_description])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :style_description])
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  CALLBACK_URL = "http://localhost:3000"

  Instagram.configure do |config|
    config.client_id = ENV["client_id"]
    config.client_secret = ENV["client_secret"]
    # For secured endpoints only
    #config.client_ips = '<Comma separated list of IPs>'
  end



end

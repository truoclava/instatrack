class SessionsController < ApplicationController

  def new
  end 

  def connect 
    params[:code] = Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
    redirect_to '/oauth/callback'
  end

  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token
    redirect_to nav_url
  end

end 

class UsersController < ApplicationController

  def index
  end 

  def recent_media
    client = Instagram.client(:access_token => session[:access_token])
    @user = client.user
    render 'recent_media'
  end 

end 

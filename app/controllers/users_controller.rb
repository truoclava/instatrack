class UsersController < ApplicationController

 
  def index
    @client = Instagram.client(:access_token => session[:access_token])
    @current_user = @client.user
    @users = User.get_users(@client)
  end

  def current_user
    @client = Instagram.client(:access_token => session[:access_token])
    @current_user = @client.user
  end 

  def user_follows
    current_user
    render 'user_follows'
  end 

  def user_recent_media
    current_user
    render 'recent_media'
  end 

  def destroy
    # destroys users table at logout
  end 


end 


class UsersController < ApplicationController

  def index
    @client = Instagram.client(:access_token => session[:access_token])
    @current_user = @client.user

    @users = User.all 
  end

  def destroy
    # destroys users table at logout
  end 


end 


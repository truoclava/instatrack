class User < ActiveRecord::Base
  has_one :media

  def self.get_users(client)
    @users = []
    client.user_follows.map do |user|
      @user = User.new
      @user.full_name = user[:full_name]
      @user.username = user[:username]
      @user.instagram_id = user[:id]
      @user.profile_picture = user[:profile_picture]
      @users << @user
      # @user.media = Media.new
    end 
    @users
  end 

end 


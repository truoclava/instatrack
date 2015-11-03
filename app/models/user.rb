class User < ActiveRecord::Base
  has_one :media, dependent: :destroy

  def self.get_users(client)
    @users = []
    client.user_follows.each do |user|
      @user = User.new
      @user.full_name = user[:full_name]
      @user.username = user[:username]
      @user.instagram_id = user[:id]
      @user.profile_picture = user[:profile_picture]
      @user.get_media(client, @user)
      if @user.media != nil 
        @users << @user
      end 
    end 
    # binding.pry
    @users
  end 

  def get_media(client, user)
    most_recent_media = client.user_recent_media(user.instagram_id.to_i, 1)[0]
    if most_recent_media
      if most_recent_media[:location]
        location = most_recent_media[:location]
        user.build_media(latitude: location[:latitude], longitude: location[:longitude], location_name: location[:name], location_id: location[:id])
      end 
    else 
      nil
    end
  end 


end 

